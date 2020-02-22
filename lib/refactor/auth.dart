import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/api.dart';
import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_paper/refactor/user_with_characters.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pedantic/pedantic.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

enum SignInMethod {
  Google,
}

class ExposedAuthCredential {
  final String idToken;
  final String accessToken;
  final AuthCredential credential;

  ExposedAuthCredential({this.idToken, this.accessToken, this.credential});
}

Future<FirebaseUser> signInFlow(SignInMethod method) async {
  ExposedAuthCredential creds;

  dwStore.dispatch(UserActions.requestLogin());

  switch (method) {
    case SignInMethod.Google:
      creds = await signInWithGoogle();
      break;
  }

  var user = await getFirebaseUser(creds?.credential);
  var loginResult = await doApiLogin(user, creds);

  dispatchFinalDataToStore(
    credentials: creds,
    firebaseUser: user,
    characters: [],
    dbLoginData: loginResult,
  );

  return user;
}

void dispatchFinalDataToStore({
  @required ExposedAuthCredential credentials,
  @required FirebaseUser firebaseUser,
  @required UserWithCharacters dbLoginData,
  @required List<Character> characters,
}) {
  if (firebaseUser == null || credentials == null) {
    dwStore.dispatch(UserActions.noLogin());
    return;
  }
  dwStore.dispatch(
    UserActions.giveCredentials(
      credentials.idToken,
      credentials.accessToken,
    ),
  );
  CharacterActions.setCharacters({
    // TODO: add when done refactoring redux and testing entity base
    // for (var char in characters)
    //   char.docID: char
  });
}

void signOutFlow(SignInMethod method) {
  switch (method) {
    case SignInMethod.Google:
      unawaited(_googleSignIn.signOut());
  }

  dwStore.dispatch(UserActions.logout());
  dwStore.dispatch(CharacterActions.remove());
}

Future<ExposedAuthCredential> signInWithGoogle() async {
  try {
    GoogleSignInAccount googleUser = await _googleSignIn.signInSilently();

    if (googleUser == null) {
      googleUser = await _googleSignIn.signIn();

      if (googleUser == null) throw 'google_user_error';
    }

    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    return ExposedAuthCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
      credential: credential,
    );
  } catch (e) {
    print(e);
    return null;
  }
}

Future<FirebaseUser> getFirebaseUser(AuthCredential creds) async {
  try {
    if (creds == null) {
      throw 'credentials_error';
    }
    var result = await _auth.signInWithCredential(creds);
    var user = result.user;
    return user;
  } catch (e) {
    print(e);
    return null;
  }
}
