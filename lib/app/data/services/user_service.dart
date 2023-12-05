import 'dart:async';

import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/data/models/user_settings.dart';
import 'package:dungeon_paper/app/data/services/auth_service.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/Migration/controllers/migration_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/core/http/api.dart';
import 'package:dungeon_paper/core/http/api_requests/migration.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/utils/secrets_base.dart';
import 'intl_service.dart';

class UserService extends GetxService
    with RepositoryServiceMixin, AuthServiceMixin, CharacterServiceMixin, LoadingServiceMixin {
  final _current = User.guest().obs;

  User get current => _current.value;
  StreamSubscription? _userDataSub;

  Future<void> loadBuiltInRepo({bool ignoreCache = false}) async {
    await repo.builtIn.dispose();
    return repo.builtIn.init(ignoreCache: ignoreCache);
  }

  Future<void> loadMyRepo({bool ignoreCache = false}) async {
    await repo.my.dispose();
    return repo.my.init(ignoreCache: ignoreCache);
  }

  Future<void> loadUserData(fba.User user) async {
    _clearUserListener();
    final email = user.email;
    debugPrint('loading user data for $email');
    api.requests.idToken = await user.getIdToken();
    StorageHandler.instance.currentDelegate = 'firestore';
    StorageHandler.instance.setCollectionPrefix('Data/$email');
    final shouldLoadRepo = current.email != user.email;
    final dbUser = await StorageHandler.instance.firestoreGlobal.getDocument('Data', email!);
    await _setUserAfterMigration(user, dbUser);
    _registerUserListener();
    charService.registerCharacterListener();

    if (shouldLoadRepo) {
      loadMyRepo();
    }

    loadingService.loadingUser = false;
    loadingService.afterFirstLoad = !loadingService.loadingCharacters;
  }

  bool get isGuest => current.isGuest;
  bool get isLoggedIn => !isGuest;

  void loadGuestData() async {
    _clearUserListener();
    StorageHandler.instance.currentDelegate = 'local';
    StorageHandler.instance.setCollectionPrefix(null);
    await loadMyRepo(ignoreCache: true);
    charService.registerCharacterListener();
    loadingService.loadingUser = false;
    loadingService.afterFirstLoad = !loadingService.loadingCharacters;
  }

  void logout() async {
    _clearUserListener();
    charService.clear();
    _current.value = User.guest();
    await authService.logout();
  }

  @override
  void onInit() {
    super.onInit();
    loadBuiltInRepo();
  }

  @override
  void onClose() {
    super.onClose();
    _userDataSub?.cancel();
  }

  // update user to Firestore
  Future<User> updateUser(User user) async {
    final email = user.email;
    debugPrint('updating user data for $email: ${user.toJson()}');
    await StorageHandler.instance.firestoreGlobal.update('Data', email, user.toJson());
    return user;
  }

  Future<User?> _migrateUser(fba.User user) async {
    final migrationDetails = await Get.toNamed(
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
    _userDataSub = StorageHandler.instance.firestoreGlobal.documentListener('Data', current.email, _updateUser);
  }

  void _updateUser(DocData? data) {
    if (data == null) {
      return;
    }
    final user = User.fromJson(data);
    _current.value = user;
    user.applySettings();
    _initUserExternal(user);
  }

  void _initUserExternal(User user) async {
    final pkg = await PackageInfo.fromPlatform();
    if (secrets.sentryDsn.isNotEmpty) {
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
      final resp = await _migrateUser(user);
      if (resp == null) {
        Get.rawSnackbar(title: tr.errors.userOperationCanceled);
        loadingService.loadingUser = false;
        loadingService.afterFirstLoad = !loadingService.loadingCharacters;
        return;
      }
      _current.value = resp;
    } else {
      _current.value = User.fromJson(dbUser);
    }
  }

  Future<void> updateEmail(String email) async {
    if (email == current.email || email.trim().isEmpty) {
      return;
    }
    assert(EmailValidator.validate(email));
    final updatedUser = current.copyWith(email: email);
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

mixin UserServiceMixin {
  UserService get userService => Get.find();
  User get user => userService.current;
}

