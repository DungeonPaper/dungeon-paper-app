import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

const scaffoldBackgroundColor = Color(0xfffcf5e5);
const primaryColor = Color(0xff8d775f);

final parchmentTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: scaffoldBackgroundColor,
    foregroundColor: ThemeData.light().colorScheme.onSurface,
    elevation: 0,
    centerTitle: true,
  ),
);
final darkTheme = ThemeData.dark().copyWith(
  // primaryColor: primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    elevation: 0,
    centerTitle: true,
  ),
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
