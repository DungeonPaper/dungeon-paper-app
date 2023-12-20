import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/core/global_keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCharacterThemeController extends ChangeNotifier{
  final seeAll = {Brightness.light: false, Brightness.dark: false};
  int? lightTheme = AppThemes.parchment;
  int? darkTheme = AppThemes.dark;

  CharacterProvider get charService => Provider.of<CharacterProvider>(appGlobalKey.currentContext!);
  Character get char => charService.current;

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

  void save() async {
    await charService.updateCharacter(
      char.copyWith(
        settings: char.settings.copyWithThemes(
          lightTheme: lightTheme,
          darkTheme: darkTheme,
        ),
      ),
    );
    notifyListeners();
    charService.switchToCharacterTheme(char);
    // Get.back();
  }
}

