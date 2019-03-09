import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/listeners.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

performSignIn() async {
  String accessToken = dwStore.state.prefs.credentials.accessToken;
  String idToken = dwStore.state.prefs.credentials.idToken;

  if (accessToken == null || idToken == null) {
    dwStore.dispatch(UserActions.noLogin());
    return null;
  }

  dwStore.dispatch(UserActions.requestLogin());
  try {
    AuthCredential creds = GoogleAuthProvider.getCredential(
      accessToken: accessToken,
      idToken: idToken,
    );

    FirebaseUser user = await auth.signInWithCredential(creds);
    await setCurrentUserByEmail(user.email);
    registerAuthUserListener();
    return user;
  } catch (e) {
    dwStore.dispatch(UserActions.noLogin());
    print(e);
    return null;
  }
}

Future requestSignInWithCredentials() async {
  try {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw 'user_canceled';
    }
    dwStore.dispatch(UserActions.requestLogin());
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    dwStore.dispatch(UserActions.giveCredentials(googleAuth.idToken, googleAuth.accessToken));

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
