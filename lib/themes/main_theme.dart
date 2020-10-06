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

var mainTheme = ThemeData(
  primarySwatch: createMaterialColor(_primary),
  accentColor: _secondary,
  scaffoldBackgroundColor: _primary,
  cardColor: Colors.white.withOpacity(0.85),
  fontFamily: 'Nunito',
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);
