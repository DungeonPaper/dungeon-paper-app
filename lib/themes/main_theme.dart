import 'package:dungeon_paper/themes/theme_helpers.dart';
import 'package:flutter/material.dart';

// final _primary = Color.fromRGBO(148, 226, 136, 1);
// final _secondary = Color.fromRGBO(146, 213, 255, 1);
// final _secondary = Color.fromRGBO(25, 126, 206, 1);

// final _primary = Color.fromRGBO(208, 244, 222, 1);
// final _secondary = Color.fromRGBO(48, 76, 137, 1);

final _primary = Color.fromRGBO(136, 212, 152, 1); // #88d498
final _secondary = Color.fromRGBO(17, 75, 95, 1); // #114b5f

// final _primary = Color.fromRGBO(243, 233, 210, 1);
// final _secondary = Color.fromRGBO(17, 75, 95, 1);
final cardRadius = BorderRadius.circular(15);
final cardRect = RoundedRectangleBorder(
  borderRadius: cardRadius,
);

final mainTheme = ThemeData(
  primarySwatch: createMaterialColor(_primary),
  accentColor: _secondary,
  scaffoldBackgroundColor: _primary,
  cardColor: Colors.white.withOpacity(0.85),
  fontFamily: 'Nunito',
  textTheme: TextTheme(
    headline6: TextStyle(color: _secondary),
  ),
  colorScheme: ColorScheme.light(
    primary: _primary,
    secondary: _secondary,
    onBackground: _secondary,
    onSecondary: Colors.white,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: _secondary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: cardRadius,
      borderSide: BorderSide(
        width: 1,
        color: Color(0xFFDDDDDD),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: cardRadius,
      borderSide: BorderSide(
        width: 2,
        color: _secondary,
      ),
    ),
    labelStyle: TextStyle(
      color: _secondary,
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    shape: cardRect,
  ),
  cardTheme: CardTheme(
    shape: cardRect,
  ),
  buttonTheme: ButtonThemeData(
    shape: cardRect,
  ),
  dialogTheme: DialogTheme(
    shape: cardRect,
  ),
);
