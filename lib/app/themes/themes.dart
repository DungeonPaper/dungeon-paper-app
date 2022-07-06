import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'theme_utils.dart';
export 'theme_utils.dart';

const parchmentBackgroundColor = Color(0xfffcf5e5);
const parchmentPrimaryColor = Color(0xff8d775f);
final secondaryColor = ThemeData.light().colorScheme.primary;

final parchmentTheme = createLightTheme(
  createColorScheme(
    parchmentPrimaryColor,
    brightness: Brightness.light,
    primary: parchmentPrimaryColor,
    secondary: secondaryColor,
  ),
  scaffoldBackgroundColor: parchmentBackgroundColor,
  brightness: Brightness.light,
);

final darkTheme = createLightTheme(
  createColorScheme(
    ThemeData.dark().colorScheme.primary,
    brightness: Brightness.dark,
    secondary: secondaryColor,
  ),
  brightness: Brightness.dark,
);

ColorScheme createColorScheme(
  Color seedColor, {
  required Brightness brightness,
  Color? secondary,
  Color? primary,
}) {
  final defaultBase =
      brightness == Brightness.light ? const ColorScheme.light() : const ColorScheme.dark();
  return ColorScheme.fromSeed(
    brightness: brightness,
    seedColor: seedColor,
    primary: primary,
    secondary: secondary,
    onSecondary:
        ThemeData.estimateBrightnessForColor(secondary ?? defaultBase.secondary) == Brightness.light
            ? Colors.black
            : Colors.white,
  );
}

class AppThemes {
  static const parchment = 0;
  static const dark = 1;

  static List<int> allLightThemes = [parchment];
  static List<int> allDarkThemes = [dark];

  static ThemeData getTheme(int theme) => themeCollection[theme];

  static const _themeNames = {
    AppThemes.parchment: 'Parchment',
    AppThemes.dark: 'Dark',
  };

  static String getThemeName(int theme) => _themeNames[theme]!;
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.parchment: parchmentTheme,
    AppThemes.dark: darkTheme,
  },
  fallbackTheme: parchmentTheme,
);
