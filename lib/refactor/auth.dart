import 'package:dungeon_paper/db/listeners.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/api.dart';
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
    dbLoginData: loginResult,
  );

  registerAllListeners();

  return user;
}

void registerAllListeners() {
  registerFirebaseUserListener();
  registerUserListener();
  registerCharactersListener();
}

void dispatchFinalDataToStore({
  @required ExposedAuthCredential credentials,
  @required FirebaseUser firebaseUser,
  @required UserWithCharacters dbLoginData,
}) async {
  var prefs = dwStore.state.prefs;
  if (firebaseUser == null || credentials == null) {
    dwStore.dispatch(UserActions.noLogin());
    return;
  }
  dwStore.dispatch(UserActions.login(
    user: dbLoginData,
    credentials: credentials,
    firebaseUser: firebaseUser,
  ));
  dwStore.dispatch(
    CharacterActions.setCharacters({
      for (var char in dbLoginData.characters) char.docID: char,
    }),
  );
  var currentID =
      prefs.user.lastCharacterId ?? dbLoginData.characters.first.docID;
  dwStore.dispatch(
    CharacterActions.setCurrentChar(
      currentID,
      dbLoginData.characters.firstWhere(
        (char) => char.docID == currentID,
        orElse: () => dbLoginData.characters.first,
      ),
    ),
  );
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

    var googleAuth = await googleUser.authentication;
    var credential = GoogleAuthProvider.getCredential(
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
