import 'dart:async';

import 'package:dungeon_paper/app/data/models/user.dart';
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
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class UserService extends GetxService
    with RepositoryServiceMixin, AuthServiceMixin, CharacterServiceMixin, LoadingServiceMixin {
  final _current = User.guest().obs;
  User get current => _current.value;
  StreamSubscription? _sub;

  Future<void> loadBuiltInRepo() {
    repo.builtIn.clear();
    repo.builtIn.clearListeners();
    return repo.builtIn.init();
  }

  Future<void> loadMyRepo() {
    repo.my.clear();
    repo.my.clearListeners();
    return repo.my.init(ignoreCache: true);
  }

  Future<void> loadUserData(fba.User user) async {
    final email = user.email;
    debugPrint('loading user data for $email');
    api.requests.idToken = await user.getIdToken();
    StorageHandler.instance.currentDelegate = 'firestore';
    StorageHandler.instance.setCollectionPrefix('Data/$email');
    await loadMyRepo();
    var dbUser = await FirestoreDelegate().getDocument('Data', email!);
    if (dbUser == null) {
      final resp = await _migrateUser(user.email!);
      if (resp == null) {
        Get.rawSnackbar(title: S.current.errorUserOperationCanceled);
        loadingService.loadingUser = false;
        loadingService.afterFirstLoad = !loadingService.loadingCharacters;
        return;
      }
      _current.value = resp;
    } else {
      _current.value = User.fromJson(dbUser);
    }
    _registerUserListener();
    charService.registerCharacterListener();
    loadingService.loadingUser = false;
    loadingService.afterFirstLoad = !loadingService.loadingCharacters;
  }

  bool get isGuest => current.isGuest;
  bool get isLoggedIn => !isGuest;

  void loadGuestData() async {
    StorageHandler.instance.currentDelegate = 'local';
    StorageHandler.instance.setCollectionPrefix(null);
    await loadMyRepo();
    charService.registerCharacterListener();
    loadingService.loadingUser = false;
    loadingService.afterFirstLoad = true;
  }

  void logout() {
    authService.logout();
    charService.clear();
    _current.value = User.guest();
  }

  @override
  void onInit() {
    super.onInit();
    loadBuiltInRepo();
  }

  // update user to Firestore
  Future<User> updateUser(User user) async {
    final email = user.email;
    debugPrint('updating user data for $email: ${user.toJson()}');
    await StorageHandler.instance.firestoreGlobal.update('Data', email, user.toJson());
    return user;
  }

  Future<User?> _migrateUser(String email) async {
    final migrationDetails = await Get.toNamed(
      Routes.migration,
      arguments: MigrationArguments(email: email),
    ) as MigrationDetails?;
    if (migrationDetails == null) {
      return null;
    }
    await api.requests.migrateUser(migrationDetails);
    final userDoc = await FirestoreDelegate().getDocument('Data', email);
    return User.fromJson(userDoc!);
  }

  void _registerUserListener() {
    _sub?.cancel();
    debugPrint('registering user listener');
    _sub = StorageHandler.instance.firestoreGlobal
        .documentListener('Data', current.email, _updateUser);
  }

  void _updateUser(DocData? data) {
    if (data == null) {
      return;
    }
    final user = User.fromJson(data);
    _current.value = user;
    if (maybeChar != null) {
      charService.switchToCharacterTheme(char);
    }
  }
}

mixin UserServiceMixin {
  UserService get userService => Get.find();
  User get user => userService.current;
}
