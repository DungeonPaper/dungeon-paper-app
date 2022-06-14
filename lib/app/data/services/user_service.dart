import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/data/services/auth_service.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class UserService extends GetxService
    with RepositoryServiceMixin, AuthServiceMixin, CharacterServiceMixin {
  final _current = User.guest().obs;
  User get current => _current.value;

  Future<void> loadUserData(fba.User user) async {
    final email = user.email;
    debugPrint('loading user data for $email');
    StorageHandler.instance.currentDelegate = 'firestore';
    StorageHandler.instance.setCollectionPrefix('Data/$email');
    repo.my.clear();
    repo.my.clearListeners();
    await repo.builtIn.init();
    await repo.my.init(ignoreCache: true);
    final dbUser = await FirestoreDelegate().getDocument('Data', email!);
    _current.value = User.fromJson(dbUser!);
    charService.registerCharacterListener();
  }

  bool get isGuest => current.isGuest;
  bool get isLoggedIn => !isGuest;

  void loadGuestData() async {
    StorageHandler.instance.currentDelegate = 'local';
    StorageHandler.instance.setCollectionPrefix(null);
    repo.my.clear();
    repo.my.clearListeners();
    await repo.builtIn.init();
    await repo.my.init(ignoreCache: true);
    charService.registerCharacterListener();
  }

  void logout() {
    authService.logout();
    charService.clear();
    _current.value = User.guest();
  }
}

mixin UserServiceMixin {
  UserService get userService => Get.find();
}
