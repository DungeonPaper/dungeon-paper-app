import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions/user_actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

performSignIn() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  String accessToken = sharedPrefs.getString('accessToken');
  String idToken = sharedPrefs.getString('idToken');

  if (accessToken == null || idToken == null) {
    dwStore.dispatch(UserActions.noLogin());
    return null;
  }

  dwStore.dispatch(UserActions.requestLogin());
  AuthCredential creds = GoogleAuthProvider.getCredential(
    accessToken: accessToken,
    idToken: idToken,
  );

  FirebaseUser user = await auth.signInWithCredential(creds);
  setCurrentUserByEmail(user.email);
  registerUserListener();
  return user;
}

void requestSignInWithCredentials() async {
  dwStore.dispatch(UserActions.requestLogin());
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  sharedPrefs.setString('accessToken', googleAuth.accessToken);
  sharedPrefs.setString('idToken', googleAuth.idToken);

  performSignIn();
}

requestSignOut() async {
  await _googleSignIn.signOut();

  unsetCurrentCharacter();
  unsetCurrentUser();
}
