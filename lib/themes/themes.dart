import 'package:dungeon_paper/themes/theme_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dungeon_paper/src/utils/class_extensions/map_extensions.dart';

class Themes extends GetxController {
  Themes._();

  static Themes _instance;
  static Themes get instance => _instance ??= Themes._();

  static ThemeData _current;
  static ThemeData get currentTheme => _current;

  ThemeData get current => _current;
  set current(ThemeData value) {
    _current = value;
    _updatePrefs();
    Get.changeTheme(value);
  }

  static void changeTheme(ThemeData value) {
    instance.current = value;
  }

  static final Map<String, ThemeData> themes = {
    'dungeon-paper': createTheme(
      primary: Color.fromRGBO(136, 212, 152, 1), // #88d498
      secondary: Color.fromRGBO(17, 75, 95, 1), // #114b5f
    ),
    'red': createTheme(
      primary: Colors.red[900],
      secondary: Color(0xFF400604),
    ),
  };

  static final main = themes['dungeon-paper'];
  static final red = themes['red'];

  static void init() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final name = prefs.getString('theme');
      final theme = themes[name];
      if (theme != null) {
        instance.current = theme;
      } else {
        throw Exception('Bad theme value provided');
      }
    } on Exception {
      instance.current = main;
    }
  }

  static void _updatePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    unawaited(prefs.setString('theme', themes.inverse[_current]));
  }
}
