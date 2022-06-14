import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum LoadKey {
  user,
  characters,
  repo,
  library,
}

class LoadingService extends GetxService {
  final _map = <LoadKey, bool>{
    LoadKey.user: false,
    LoadKey.characters: false,
  }.obs;

  void setLoading(LoadKey key, bool value) {
    _map[key] = value;
  }

  bool isLoading(LoadKey key) => _map[key] == true;
}

mixin LoadingServiceMixin {
  LoadingService get loadingService => Get.find();
}
