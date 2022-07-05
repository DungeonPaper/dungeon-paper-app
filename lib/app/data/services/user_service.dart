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
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class UserService extends GetxService
    with RepositoryServiceMixin, AuthServiceMixin, CharacterServiceMixin, LoadingServiceMixin {
  final _current = User.guest().obs;
  User get current => _current.value;

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
    StorageHandler.instance.currentDelegate = 'firestore';
    StorageHandler.instance.setCollectionPrefix('Data/$email');
    await loadMyRepo();
    var dbUser = await FirestoreDelegate().getDocument('Data', email!);
    if (dbUser == null) {
      final resp = await _migrateUser(user.email!);
      if (resp == null) {
        // TODO intl
        Get.rawSnackbar(title: 'Canceled');
        loadingService.loadingUser = false;
        return;
      }
      _current.value = resp;
    } else {
      _current.value = User.fromJson(dbUser);
    }
    charService.registerCharacterListener();
    loadingService.loadingUser = false;
  }

  bool get isGuest => current.isGuest;
  bool get isLoggedIn => !isGuest;

  void loadGuestData() async {
    StorageHandler.instance.currentDelegate = 'local';
    StorageHandler.instance.setCollectionPrefix(null);
    await loadMyRepo();
    charService.registerCharacterListener();
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
}

mixin UserServiceMixin {
  UserService get userService => Get.find();
}
