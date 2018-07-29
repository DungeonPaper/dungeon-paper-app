import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth auth = FirebaseAuth.instance;

performSignIn() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  String accessToken = sharedPrefs.getString('accessToken');
  String idToken = sharedPrefs.getString('idToken');

  if (accessToken == null || idToken == null) {
    return null;
  }

  FirebaseUser user = await auth.signInWithGoogle(
    accessToken: accessToken,
    idToken: idToken,
  );

  return user;
}
