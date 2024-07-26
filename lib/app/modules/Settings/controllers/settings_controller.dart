import 'package:dungeon_paper/app/data/models/user_settings.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:flutter/material.dart';

class SettingsController extends ChangeNotifier
    with CharacterProviderMixin, UserProviderMixin {
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

  void setLightTheme(int theme) {
    updateSettings(
      settings.copyWith(defaultLightTheme: theme),
    );
    if (user.brightness == Brightness.light) {
      if (maybeChar != null) {
        final character = charProvider.current;
        charProvider.switchToCharacterTheme(character);
      } else {
        charProvider.switchToTheme(theme);
      }
    }
    notifyListeners();
  }

  void setDarkTheme(int theme) {
    updateSettings(
      settings.copyWith(defaultDarkTheme: theme),
    );
    if (user.brightness == Brightness.dark) {
      if (maybeChar != null) {
        final character = charProvider.current;
        charProvider.switchToCharacterTheme(character);
      } else {
        charProvider.switchToTheme(theme);
      }
    }
    notifyListeners();
  }

  void setSeeAll(Brightness brightness, bool value) {
    seeAll[brightness] = value;
    notifyListeners();
  }

  Future<void> updateSettings(UserSettings settings) {
    return userProvider.updateUser(user.copyWith(settings: settings));
  }
}
