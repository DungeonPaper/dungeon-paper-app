import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'theme_utils.dart';

const scaffoldBackgroundColor = Color(0xfffcf5e5);
const primaryColor = Color(0xff8d775f);
final borderRadius = BorderRadius.circular(20);
final rRectShape = RoundedRectangleBorder(borderRadius: borderRadius);
final baseCardTheme = CardTheme(shape: rRectShape);
final _dark = ThemeData.dark();
final _light = ThemeData.light();
final _lightM3 = ThemeData(useMaterial3: true);
const _fabTheme = FloatingActionButtonThemeData(
  backgroundColor: DwColors.success,
  foregroundColor: Colors.white,
);
final inputBorderRadius = borderRadius.copyWith(
  bottomLeft: const Radius.circular(8),
  bottomRight: const Radius.circular(8),
);
final inputDecorationTheme = InputDecorationTheme(
  floatingLabelBehavior: FloatingLabelBehavior.always,
  filled: true,
  border: UnderlineInputBorder(
    // borderSide: BorderSide.none,
    borderRadius: inputBorderRadius,
  ),
);

final parchmentTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  colorScheme: _light.colorScheme.copyWith(secondary: primaryColor, tertiary: primaryColor),
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: scaffoldBackgroundColor,
    foregroundColor: ThemeData.light().colorScheme.onSurface,
    elevation: 0,
    centerTitle: true,
  ),
  dialogTheme: DialogTheme(
    shape: rRectShape,
  ),
  cardTheme: baseCardTheme,
  fontFamily: 'Nunito',
  bottomNavigationBarTheme: _light.bottomNavigationBarTheme.copyWith(
    backgroundColor: scaffoldBackgroundColor,
    // selectedItemColor: primaryColor,
    // showSelectedLabels: false,
  ),
  popupMenuTheme: PopupMenuThemeData(
    shape: rRectShape,
  ),
  inputDecorationTheme: inputDecorationTheme,
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     primary: primaryColor,
  //     shape: rRectShape,
  //   ),
  // ),
  floatingActionButtonTheme: _fabTheme,
);
final darkTheme = _dark.copyWith(
  // primaryColor: primaryColor,
  useMaterial3: true,
  textTheme: copyTextThemeWith(_dark.textTheme, fontFamily: 'Nunito'),
  primaryTextTheme: copyTextThemeWith(_dark.primaryTextTheme, fontFamily: 'Nunito'),
  appBarTheme: AppBarTheme(
    backgroundColor: _dark.scaffoldBackgroundColor,
    elevation: 0,
    centerTitle: true,
  ),
  dialogTheme: DialogTheme(
    shape: rRectShape,
  ),
  cardTheme: baseCardTheme,
  popupMenuTheme: PopupMenuThemeData(
    shape: rRectShape,
  ),
  inputDecorationTheme: inputDecorationTheme,
  splashFactory: _lightM3.splashFactory,
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     primary: _dark.primaryColor,
  //     shape: rRectShape,
  //   ),
  // ),
  floatingActionButtonTheme: _fabTheme,
);

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
