import 'dart:async';

import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/data/models/user_settings.dart';
import 'package:dungeon_paper/app/data/services/auth_provider.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/data/services/loading_provider.dart';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/app/modules/Migration/controllers/migration_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/core/global_keys.dart';
import 'package:dungeon_paper/core/http/api.dart';
import 'package:dungeon_paper/core/http/api_requests/migration.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/utils/secrets_base.dart';

class UserProvider extends ChangeNotifier with RepositoryProviderMixin {
  var _current = User.guest();

  User get current => _current;
  StreamSubscription? _userDataSub;

  UserProvider() {
    // loadBuiltInRepo();
  }

  static UserProvider of(BuildContext context) =>
      Provider.of<UserProvider>(context, listen: false);

  static consumer(BuildContext context, Widget Function(User) builder) =>
      Consumer<UserProvider>(
        builder: (context, provider, _) => builder(provider.current),
      );

  Future<void> loadBuiltInRepo({bool ignoreCache = false}) async {
    // await repo.builtIn.dispose();
    return repo.builtIn.init(ignoreCache: ignoreCache);
  }

  Future<void> loadMyRepo({bool ignoreCache = false}) async {
    // await repo.my.dispose();
    return repo.my.init(ignoreCache: ignoreCache);
  }

  Future<void> loadUserData(fba.User user) async {
    _clearUserListener();
    await loadBuiltInRepo();
    final email = user.email;
    debugPrint('loading user data for $email');
    api.requests.idToken = await user.getIdToken();
    StorageHandler.instance.currentDelegate = 'firestore';
    StorageHandler.instance.setCollectionPrefix('Data/$email');
    final shouldLoadRepo = current.email != user.email;
    final dbUser = await StorageHandler.instance.firestoreGlobal
        .getDocument('Data', email!);
    await _setUserAfterMigration(user, dbUser);
    _registerUserListener();
    final charProvider = Provider.of<CharacterProvider>(
        appGlobalKey.currentContext!,
        listen: false);
    charProvider.registerCharacterListener();

    if (shouldLoadRepo) {
      loadMyRepo();
    }

    final loadingProvider = Provider.of<LoadingProvider>(
        appGlobalKey.currentContext!,
        listen: false);
    loadingProvider.loadingUser = false;
    loadingProvider.afterFirstLoad = !loadingProvider.loadingCharacters;
  }

  bool get isGuest => current.isGuest;
  bool get isLoggedIn => !isGuest;

  void loadGuestData() async {
    _clearUserListener();
    await loadBuiltInRepo();
    StorageHandler.instance.currentDelegate = 'local';
    StorageHandler.instance.setCollectionPrefix(null);
    notifyListeners();
    await loadMyRepo(ignoreCache: true);
    final charProvider = Provider.of<CharacterProvider>(
        appGlobalKey.currentContext!,
        listen: false);
    final loadingProvider = Provider.of<LoadingProvider>(
        appGlobalKey.currentContext!,
        listen: false);
    charProvider.registerCharacterListener();
    loadingProvider.loadingUser = false;
    loadingProvider.afterFirstLoad = !loadingProvider.loadingCharacters;
    notifyListeners();
  }

  void logout() async {
    _clearUserListener();
    final charProvider = Provider.of<CharacterProvider>(
        appGlobalKey.currentContext!,
        listen: false);
    charProvider.clear();
    _current = User.guest();
    final context = appGlobalKey.currentContext!;
    final authService = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    await authService.logout(context);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _userDataSub?.cancel();
  }

  // update user to Firestore
  Future<User> updateUser(User user) async {
    final email = user.email;
    debugPrint('updating user data for $email: ${user.toJson()}');
    await StorageHandler.instance.firestoreGlobal
        .update('Data', email, user.toJson());
    return user;
  }

  Future<User?> _migrateUser(fba.User user) async {
    final context = appGlobalKey.currentContext!;
    final migrationDetails = await Navigator.of(context).pushNamed(
      Routes.migration,
      arguments: MigrationArguments(email: user.email ?? ''),
    ) as MigrationDetails?;
    if (migrationDetails == null) {
      return null;
    }
    await api.requests.migrateUser(migrationDetails);
    final userDoc = await FirestoreDelegate().getDocument('Data', user.email!);
    if (userDoc != null) {
      return User.fromJson(userDoc);
    }
    final newUser = User(
      displayName: user.displayName ?? migrationDetails.username,
      email: user.email!,
      flags: {},
      photoUrl: user.photoURL ?? '',
      settings: UserSettings(),
      username: migrationDetails.username,
    );
    await FirestoreDelegate().create('Data', user.email!, newUser.toJson());
    return newUser;
  }

  void _registerUserListener() {
    _clearUserListener();
    debugPrint('registering user listener');
    _userDataSub = StorageHandler.instance.firestoreGlobal
        .documentListener('Data', current.email, _updateUser);
  }

  void _updateUser(DocData? data) {
    if (data == null) {
      return;
    }
    final user = User.fromJson(data);
    _current = user;
    notifyListeners();
    user.applySettings();
    _initUserExternal(user);
  }

  void _initUserExternal(User user) async {
    final pkg = await PackageInfo.fromPlatform();
    if (secrets.sentryDsn.isNotEmpty) {
      final authService = Provider.of<AuthProvider>(
        appGlobalKey.currentContext!,
        listen: false,
      );
      Sentry.configureScope(
        (scope) => scope.setUser(
          SentryUser(
            email: user.email,
            id: authService.fbUser?.uid,
            username: user.username,
            data: {
              'displayName': user.displayName,
              'version': pkg.version,
            },
          ),
        ),
      );
    }
  }

  Future<void> _setUserAfterMigration(fba.User user, DocData? dbUser) async {
    final needsMigration = dbUser == null;

    if (needsMigration) {
      final context = appGlobalKey.currentContext!;
      final messenger = ScaffoldMessenger.of(context);
      final loadingProvider =
          Provider.of<LoadingProvider>(context, listen: false);
      final resp = await _migrateUser(user);
      if (resp == null) {
        messenger.showSnackBar(
            SnackBar(content: Text(tr.errors.userOperationCanceled)));

        loadingProvider.loadingUser = false;
        loadingProvider.afterFirstLoad = !loadingProvider.loadingCharacters;
        return;
      }
      _current = resp;
    } else {
      _current = User.fromJson(dbUser);
    }
    notifyListeners();
  }

  Future<void> updateEmail(String email) async {
    if (email == current.email || email.trim().isEmpty) {
      return;
    }
    assert(EmailValidator.validate(email));
    final updatedUser = current.copyWith(email: email);
    final authService = Provider.of<AuthProvider>(
      appGlobalKey.currentContext!,
      listen: false,
    );
    await authService.fbUser!.updateEmail(email);
    await updateUser(updatedUser);
    loadUserData(fba.FirebaseAuth.instance.currentUser!);
  }

  void _clearUserListener() {
    debugPrint('clearing user listener');
    _userDataSub?.cancel();
    _userDataSub = null;
  }
}

mixin UserProviderMixin {
  UserProvider get userProvider =>
      UserProvider.of(appGlobalKey.currentContext!);
  User get user => userProvider.current;
}
