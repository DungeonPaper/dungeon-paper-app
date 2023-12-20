import 'package:dungeon_paper/app/data/models/user_settings.dart';
import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:flutter/material.dart';

class SettingsController extends ChangeNotifier with UserProviderMixin {
  final seeAll = {Brightness.light: false, Brightness.dark: false};

  UserSettings get settings => user.settings;

  SettingsController(BuildContext context) {
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
    return userProvider.updateUser(user.copyWith(settings: settings));
  }
}

