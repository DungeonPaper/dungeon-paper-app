import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/listeners.dart';
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
  registerAuthUserListener();
  return user;
}

Future requestSignInWithCredentials() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  try {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw 'user_canceled';
    }
    dwStore.dispatch(UserActions.requestLogin());
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    sharedPrefs.setString('accessToken', googleAuth.accessToken);
    sharedPrefs.setString('idToken', googleAuth.idToken);

    return performSignIn();
  } catch (e) {
    dwStore.dispatch(UserActions.noLogin());
    if (e != 'user_canceled') {
      throw e;
    }
    return null;
  }
}

requestSignOut() async {
  await _googleSignIn.signOut();

  unsetCurrentCharacter();
  unsetCurrentUser();
}
