import 'package:dungeon_paper/db/listeners.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../error_reporting.dart';
import 'character_db.dart';

class PaperAuth {
  final GoogleSignIn _gg = GoogleSignIn();
  final FirebaseAuth _fb = FirebaseAuth.instance;

  void _prepSignIn() {
    dwStore.dispatch(UserActions.requestLogin());
  }

  void _cancelSignIn() {
    dwStore.dispatch(UserActions.noLogin());
  }

  Future<FirebaseUser> getFirebaseUser(AuthCredential creds) async {
    _prepSignIn();
    try {
      var result = await _fb.signInWithCredential(creds);
      var user = result.user;
      await setCurrentUser(user);
      registerAuthUserListener();
      registerUserContext(user);
      return user;
    } catch (e) {
      _cancelSignIn();
      print(e);
      return null;
    }
  }

  Future<AuthCredential> signInWithGoogle() async {
    _prepSignIn();
    try {
      GoogleSignInAccount googleUser = await _gg.signInSilently();

      if (googleUser == null) {
        googleUser = await _gg.signIn();

        if (googleUser == null) throw 'user_canceled';
      }

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      dwStore.dispatch(UserActions.giveCredentials(
          googleAuth.idToken, googleAuth.accessToken));

      return GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    } catch (e) {
      _cancelSignIn();
      print(e);
      return null;
    }
  }

  requestSignOut() async {
    await _gg.signOut();
    unsetCurrentCharacter();
    unsetCurrentUser();
  }
}

PaperAuth auth = PaperAuth();
