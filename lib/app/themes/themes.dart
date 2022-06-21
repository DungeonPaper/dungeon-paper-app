import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'theme_utils.dart';

const scaffoldBackgroundColor = Color(0xfffcf5e5);
const primaryColor = Color(0xff8d775f);
final _light = ThemeData.light();
final secondaryColor = _light.colorScheme.primary;
final borderRadius = BorderRadius.circular(20);
final rRectShape = RoundedRectangleBorder(borderRadius: borderRadius);
final _dark = ThemeData.dark();
final parchmentColorScheme = ColorScheme.fromSeed(
  seedColor: primaryColor,
  primary: primaryColor,
  secondary: secondaryColor,
  onSecondary: ThemeData.estimateBrightnessForColor(secondaryColor) == Brightness.light
      ? Colors.black
      : Colors.white,
);
final darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: _dark.colorScheme.primary,
  secondary: secondaryColor,
  onSecondary: ThemeData.estimateBrightnessForColor(secondaryColor) == Brightness.light
      ? Colors.black
      : Colors.white,
);
final _lightM3 = ThemeData(
  useMaterial3: true,
  colorScheme: parchmentColorScheme,
  primaryColor: parchmentColorScheme.primary,
);
final _darkM3 = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  primaryColor: darkColorScheme.primary,
);
final baseCardTheme = _lightM3.cardTheme.copyWith(shape: rRectShape);
final inputBorderRadius = borderRadius.copyWith(
  bottomLeft: const Radius.circular(8),
  bottomRight: const Radius.circular(8),
);
final inputDecorationTheme = InputDecorationTheme(
  floatingLabelBehavior: FloatingLabelBehavior.always,
  filled: true,
  border: UnderlineInputBorder(
    borderRadius: inputBorderRadius,
  ),
);

final parchmentBase = ThemeData.from(
  useMaterial3: true,
  colorScheme: parchmentColorScheme,
  textTheme: copyTextThemeWith(
    _lightM3.textTheme,
    fontFamily: 'Nunito',
  ),
);

final darkBase = ThemeData.from(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: copyTextThemeWith(
    _darkM3.textTheme,
    fontFamily: 'Nunito',
  ),
);

final parchmentTheme = parchmentBase.copyWith(
  useMaterial3: true,
  splashColor: secondaryColor.withOpacity(0.1),
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  appBarTheme: parchmentBase.appBarTheme.copyWith(
    backgroundColor: Colors.transparent,
    foregroundColor: ThemeData.light().colorScheme.onSurface,
    elevation: 0,
    centerTitle: true,
  ),
  dialogTheme: parchmentBase.dialogTheme.copyWith(
    shape: rRectShape,
  ),
  cardTheme: parchmentBase.cardTheme.copyWith(shape: rRectShape),
  popupMenuTheme: parchmentBase.popupMenuTheme.copyWith(
    shape: rRectShape,
  ),
  inputDecorationTheme: parchmentBase.inputDecorationTheme.copyWith(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    filled: true,
    border: UnderlineInputBorder(
      borderRadius: inputBorderRadius,
    ),
  ),
  floatingActionButtonTheme: parchmentBase.floatingActionButtonTheme.copyWith(
    backgroundColor: DwColors.success,
    foregroundColor: Colors.white,
  ),
);

final parchmentSplashColor = parchmentTheme.colorScheme.secondary.withOpacity(0.2);

final darkTheme = darkBase.copyWith(
  useMaterial3: true,
  splashColor: secondaryColor.withOpacity(0.1),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
  ),
  dialogTheme: darkBase.dialogTheme.copyWith(
    shape: rRectShape,
  ),
  cardTheme: darkBase.cardTheme.copyWith(shape: rRectShape),
  popupMenuTheme: darkBase.popupMenuTheme.copyWith(
    shape: rRectShape,
  ),
  inputDecorationTheme: darkBase.inputDecorationTheme.copyWith(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    filled: true,
    border: UnderlineInputBorder(
      borderRadius: inputBorderRadius,
    ),
  ),
  splashFactory: InkSparkle.splashFactory,
  floatingActionButtonTheme: darkBase.floatingActionButtonTheme.copyWith(
    backgroundColor: DwColors.success,
    foregroundColor: Colors.white,
  ),
);
final darkSplashColor = darkTheme.colorScheme.secondary.withOpacity(0.2);

class AppThemes {
  static const parchment = 0;
  static const dark = 1;
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.parchment: parchmentTheme,
    AppThemes.dark: darkTheme,
  },
  fallbackTheme: parchmentTheme,
);
