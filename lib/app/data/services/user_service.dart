import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class UserService extends GetxService with RepositoryServiceMixin {
  final _current = User.guest().obs;
  User get current => _current.value;

  void loadUserData(fba.User user) async {
    final email = user.email;
    debugPrint('loading user data for $email');
    StorageHandler.instance.currentDelegate = 'firestore';
    StorageHandler.instance.setCollectionPrefix('Data/$email');
    repo.loadAllData();
    final dbUser = await FirestoreDelegate().getDocument('Data', email!);
    _current.value = User.fromJson(dbUser!);
  }

  bool get isGuest => current.isGuest;
}

mixin UserServiceMixin {
  UserService get userService => Get.find();
}
