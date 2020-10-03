import 'package:dungeon_paper/themes/theme_helpers.dart';
import 'package:flutter/material.dart';

var _primary = Color.fromRGBO(148, 226, 136, 1);
// var _secondary = Color.fromRGBO(146, 213, 255, 1);
var _secondary = Color.fromRGBO(25, 126, 206, 1);

var mainTheme = ThemeData(
  primarySwatch: createMaterialColor(_primary),
  accentColor: _secondary,
  scaffoldBackgroundColor: _primary,
);
