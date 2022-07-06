import 'package:dungeon_paper/app/data/models/user_settings.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController with UserServiceMixin {
  final seeAll = {Brightness.light: false, Brightness.dark: false}.obs;

  @override
  void onReady() {
    super.onReady();
    if (!AppThemes.allLightThemes.contains(settings.defaultLightTheme)) {
      seeAll[Brightness.light] = true;
    }
    if (!AppThemes.allDarkThemes.contains(settings.defaultDarkTheme)) {
      seeAll[Brightness.dark] = true;
    }
  }

  Future<void> updateSettings(UserSettings settings) {
    return userService.updateUser(user.copyWith(settings: settings));
  }

  UserSettings get settings => user.settings;
}
