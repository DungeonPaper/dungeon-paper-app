import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

Future<SharedPreferences> loadSharedPrefs() async {
  return prefs = await SharedPreferences.getInstance();
}
