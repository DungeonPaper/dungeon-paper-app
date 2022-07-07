import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'theme_utils.dart';
export 'theme_utils.dart';

const parchmentBackgroundColor = Color(0xfffcf5e5);
const parchmentPrimaryColor = Color(0xff8d775f);
final secondaryColor = ThemeData.light().colorScheme.primary;

final parchmentTheme = createTheme(
  createColorScheme(
    parchmentPrimaryColor,
    brightness: Brightness.light,
    primary: parchmentPrimaryColor,
    secondary: secondaryColor,
  ),
  scaffoldBackgroundColor: parchmentBackgroundColor,
  brightness: Brightness.light,
);

final legacyTheme = createTheme(
  createColorScheme(
    const Color.fromARGB(255, 136, 212, 152),
    brightness: Brightness.light,
    primary: const Color.fromARGB(255, 17, 76, 95),
    secondary: const Color.fromARGB(255, 17, 76, 95),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 136, 212, 152),
  brightness: Brightness.light,
);

final darkTheme = createTheme(
  createColorScheme(
    ThemeData.dark().colorScheme.primary,
    brightness: Brightness.dark,
    secondary: secondaryColor,
  ),
  brightness: Brightness.dark,
);

final abyssTheme = createTheme(
  createColorScheme(
    Colors.black,
    brightness: Brightness.dark,
    primary: Colors.purple,
    secondary: Color.fromARGB(255, 152, 74, 165),
    highContrast: true,
  ),
  brightness: Brightness.dark,
);

final skyTheme = createTheme(
    createColorScheme(
      Colors.cyan,
      brightness: Brightness.light,
      primary: Colors.blue[900],
      secondary: Colors.blue[900],
    ),
    scaffoldBackgroundColor: Colors.cyan[100],
    brightness: Brightness.light,
    surfaceColor: Color.fromARGB(255, 221, 252, 255));

final forestTheme = createTheme(
  createColorScheme(
    Colors.lightGreen,
    brightness: Brightness.light,
    primary: Colors.brown,
    secondary: Colors.brown,
  ),
  scaffoldBackgroundColor: Colors.lightGreen[200],
  brightness: Brightness.light,
);

final depthsTheme = createTheme(
  createColorScheme(
    Color.fromARGB(255, 4, 28, 63),
    brightness: Brightness.dark,
    // primary: Colors.green[900],
    // secondary: Colors.green[900],
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 4, 28, 63),
  brightness: Brightness.dark,
  surfaceColor: Color.fromARGB(255, 1, 12, 31),
);

final fairyTheme = createTheme(
  createColorScheme(
    Colors.pink,
    brightness: Brightness.light,
    primary: Colors.purple,
    secondary: Colors.purple,
  ),
  scaffoldBackgroundColor: Colors.pink[100],
  brightness: Brightness.light,
  surfaceColor: Color.fromARGB(255, 255, 226, 236),
);

final luxuryTheme = createTheme(
  createColorScheme(
    Color.fromARGB(255, 95, 8, 55),
    brightness: Brightness.dark,
    primary: Colors.purple,
    secondary: Colors.red[900],
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 79, 5, 45),
  brightness: Brightness.dark,
  surfaceColor: Color.fromARGB(255, 47, 2, 26),
);

final infernoTheme = createTheme(
  createColorScheme(
    Color.fromARGB(255, 82, 4, 4),
    brightness: Brightness.dark,
    primary: Colors.orange[900],
    secondary: Colors.orange[900],
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 82, 4, 4),
  brightness: Brightness.dark,
  surfaceColor: Color.fromARGB(255, 50, 2, 2),
);

final bonfireTheme = createTheme(
  createColorScheme(
    Color.fromARGB(255, 83, 21, 21),
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 179, 21, 3),
    secondary: Color.fromARGB(255, 188, 71, 32),
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 255, 184, 153),
  brightness: Brightness.light,
  surfaceColor: Color.fromARGB(255, 255, 228, 208),
);

final marshTheme = createTheme(
  createColorScheme(
    Color.fromARGB(255, 17, 71, 20),
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 89, 113, 3),
    secondary: Color.fromARGB(255, 89, 113, 3),
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 9, 44, 10),
  brightness: Brightness.dark,
  surfaceColor: Color.fromARGB(255, 4, 23, 4),
);

class AppThemes {
  static const parchment = 0;
  static const dark = 1;
  static const legacy = 2;
  static const abyss = 3;
  static const sky = 4;
  static const forest = 5;
  static const depths = 6;
  static const inferno = 7;
  static const fairy = 8;
  static const bonfire = 9;
  static const marsh = 10;
  static const luxury = 11;

  static List<int> allThemes = themes.keys.toList();

  static List<int> allLightThemes = themes.entries
      .where((e) => e.value.brightness == Brightness.light)
      .map((e) => e.key)
      .toList();

  static List<int> allDarkThemes =
      themes.entries.where((e) => e.value.brightness == Brightness.dark).map((e) => e.key).toList();

  static ThemeData getTheme(int theme) => themeCollection[theme];
  static String getThemeName(int theme) => _themeNames[theme]!;

  static final themes = {
    // Light themes
    AppThemes.parchment: parchmentTheme,
    AppThemes.legacy: legacyTheme,
    AppThemes.sky: skyTheme,
    AppThemes.bonfire: bonfireTheme,
    AppThemes.forest: forestTheme,
    AppThemes.fairy: fairyTheme,

    // Dark themes
    AppThemes.dark: darkTheme,
    AppThemes.abyss: abyssTheme,
    AppThemes.depths: depthsTheme,
    AppThemes.inferno: infernoTheme,
    AppThemes.marsh: marshTheme,
    AppThemes.luxury: luxuryTheme,
  };

  static const _themeNames = {
    AppThemes.parchment: 'Parchment',
    AppThemes.dark: 'Dark',
    AppThemes.legacy: 'Legacy',
    AppThemes.abyss: 'Abyss',
    AppThemes.sky: 'Sky',
    AppThemes.forest: 'Forest',
    AppThemes.depths: 'Depths',
    AppThemes.inferno: 'Inferno',
    AppThemes.fairy: 'Fairy',
    AppThemes.bonfire: 'Bonfire',
    AppThemes.marsh: 'Marsh',
    AppThemes.luxury: 'Luxury',
  };
}

final themeCollection = ThemeCollection(
  themes: AppThemes.themes,
  fallbackTheme: parchmentTheme,
);
