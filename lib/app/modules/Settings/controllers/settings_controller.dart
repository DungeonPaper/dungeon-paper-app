import 'package:dungeon_paper/app/data/models/user_settings.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:flutter/material.dart';

class SettingsController extends ChangeNotifier with UserServiceMixin {
  final seeAll = {Brightness.light: false, Brightness.dark: false};

  SettingsController() {
    if (!AppThemes.allLightThemes.contains(settings.defaultLightTheme)) {
      seeAll[Brightness.light] = true;
    }
    if (!AppThemes.allDarkThemes.contains(settings.defaultDarkTheme)) {
      seeAll[Brightness.dark] = true;
    }
  }

  void toggleSeeAll(Brightness brightness) {
    seeAll[brightness] = !seeAll[brightness]!;
    notifyListeners();
  }

  Future<void> updateSettings(UserSettings settings) {
    return userService.updateUser(user.copyWith(settings: settings));
  }

  UserSettings get settings => user.settings;
}
