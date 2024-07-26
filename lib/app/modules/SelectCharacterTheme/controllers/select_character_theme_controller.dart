import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:flutter/material.dart';

class SelectCharacterThemeController extends ChangeNotifier
    with CharacterProviderMixin {
  final seeAll = {Brightness.light: false, Brightness.dark: false};
  int? lightTheme = AppThemes.parchment;
  int? darkTheme = AppThemes.dark;

  SelectCharacterThemeController() {
    lightTheme = char.settings.lightTheme;
    darkTheme = char.settings.darkTheme;
    if (lightTheme != null && !AppThemes.allLightThemes.contains(lightTheme)) {
      seeAll[Brightness.light] = true;
    }
    if (darkTheme != null && !AppThemes.allDarkThemes.contains(darkTheme)) {
      seeAll[Brightness.dark] = true;
    }
  }

  void setLightTheme(int? theme) {
    lightTheme = theme;
    notifyListeners();
  }

  void setDarkTheme(int? theme) {
    darkTheme = theme;
    notifyListeners();
  }

  void setSeeAll(Brightness brightness, bool value) {
    seeAll[brightness] = value;
    notifyListeners();
  }

  void save() async {
    await charProvider.updateCharacter(
      char.copyWith(
        settings: char.settings.copyWithThemes(
          lightTheme: lightTheme,
          darkTheme: darkTheme,
        ),
      ),
    );
    notifyListeners();
    charProvider.switchToCharacterTheme(char);
    // Get.back();
  }
}
