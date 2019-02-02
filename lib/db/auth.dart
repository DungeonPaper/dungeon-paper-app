import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth auth = FirebaseAuth.instance;

performSignIn() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  String accessToken = sharedPrefs.getString('accessToken');
  String idToken = sharedPrefs.getString('idToken');
  AuthCredential creds = GoogleAuthProvider.getCredential(
    accessToken: accessToken,
    idToken: idToken,
  );

  if (accessToken == null || idToken == null) {
    return null;
  }

  FirebaseUser user = await auth.signInWithCredential(creds);

  return user;
}
