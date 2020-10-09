import 'package:dungeon_paper/themes/theme_helpers.dart';
import 'package:flutter/material.dart';

// var _primary = Color.fromRGBO(148, 226, 136, 1);
// var _secondary = Color.fromRGBO(146, 213, 255, 1);
// var _secondary = Color.fromRGBO(25, 126, 206, 1);

// var _primary = Color.fromRGBO(208, 244, 222, 1);
// var _secondary = Color.fromRGBO(48, 76, 137, 1);

var _primary = Color.fromRGBO(136, 212, 152, 1); // #88d498
var _secondary = Color.fromRGBO(17, 75, 95, 1); // #114b5f

// var _primary = Color.fromRGBO(243, 233, 210, 1);
// var _secondary = Color.fromRGBO(17, 75, 95, 1);
var cardRadius = BorderRadius.circular(15);
var cardRect = RoundedRectangleBorder(
  borderRadius: cardRadius,
);
var cardColor = Colors.white.withOpacity(0.85);
var normalInputBorder = OutlineInputBorder(
  borderRadius: cardRadius,
  borderSide: BorderSide(
    width: 1,
    color: Color(0xFF000000).withOpacity(0.2),
  ),
);

var mainTheme = ThemeData(
  primarySwatch: createMaterialColor(_primary),
  accentColor: _secondary,
  scaffoldBackgroundColor: _primary,
  cardColor: cardColor,
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
    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    filled: true,
    border: normalInputBorder,
    enabledBorder: normalInputBorder,
    fillColor: Colors.white.withOpacity(0.5),
    floatingLabelBehavior: FloatingLabelBehavior.always,
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
    color: cardColor.withOpacity(1),
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
