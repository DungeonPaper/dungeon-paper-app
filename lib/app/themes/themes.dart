import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'theme_utils.dart';

const scaffoldBackgroundColor = Color(0xfffcf5e5);
const primaryColor = Color(0xff8d775f);
final borderRadius = BorderRadius.circular(10);
final rRectShape = RoundedRectangleBorder(borderRadius: borderRadius);
final baseCardTheme = CardTheme(shape: rRectShape);

final parchmentTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: scaffoldBackgroundColor,
    foregroundColor: ThemeData.light().colorScheme.onSurface,
    elevation: 0,
    centerTitle: true,
  ),
  cardTheme: baseCardTheme,
  fontFamily: "Nunito",
);
final _dark = ThemeData.dark();
final darkTheme = _dark.copyWith(
  // primaryColor: primaryColor,
  textTheme: copyTextThemeWith(_dark.textTheme, fontFamily: "Nunito"),
  primaryTextTheme: copyTextThemeWith(_dark.primaryTextTheme, fontFamily: "Nunito"),
  appBarTheme: AppBarTheme(
    backgroundColor: _dark.scaffoldBackgroundColor,
    elevation: 0,
    centerTitle: true,
  ),
  cardTheme: baseCardTheme,
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
