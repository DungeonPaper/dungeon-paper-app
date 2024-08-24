import 'package:shared_preferences/shared_preferences.dart';

class PrefKeys {
  static const selectedThemeId = 'selectedThemeId';
  static const lastLoadedCharacter = 'lastLoadedCharacter';
  static const locale = 'locale';
}

late SharedPreferences prefs;

Future<SharedPreferences> loadSharedPrefs() async {
  return prefs = await SharedPreferences.getInstance();
}