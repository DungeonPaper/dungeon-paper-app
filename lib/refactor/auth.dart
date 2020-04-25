import 'package:dungeon_paper/db/listeners.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/api.dart';
import 'package:dungeon_paper/refactor/user.dart';
import 'package:dungeon_paper/refactor/user_with_characters.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pedantic/pedantic.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _googleSignInInstance;
Future<GoogleSignIn> get _googleSignIn async {
  if (_googleSignInInstance == null) {
    var secrets = await loadSecrets();
    var inst = kIsWeb
        ? GoogleSignIn(clientId: secrets.GOOGLE_CLIENT_ID)
        : GoogleSignIn();
    _googleSignInInstance = inst;
  }
  return _googleSignInInstance;
}

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

  registerAllListeners(user);

  return user;
}

void registerAllListeners(FirebaseUser fbUser) {
  registerFirebaseUserListener();
  registerUserListener(fbUser);
  registerCharactersListener();
}

void dispatchFinalDataToStore({
  @required ExposedAuthCredential credentials,
  @required FirebaseUser firebaseUser,
  @required UserWithChildren dbLoginData,
}) async {
  var prefs = dwStore.state.prefs;
  var user = User(
      data: dbLoginData.toJSON()..remove('characters'), ref: dbLoginData.ref);
  var characters = dbLoginData.characters;

  if (firebaseUser == null || credentials == null) {
    dwStore.dispatch(UserActions.noLogin());
    return;
  }

  dwStore.dispatch(UserActions.login(
    user: user,
    credentials: credentials,
    firebaseUser: firebaseUser,
  ));

  dwStore.dispatch(
    CharacterActions.setCharacters({
      for (var char in characters) char.docID: char,
    }),
  );

  if (characters.isNotEmpty) {
    var currentID = prefs.user.lastCharacterId ?? characters.first.docID;
    dwStore.dispatch(
      CharacterActions.setCurrentChar(
        currentID,
        characters.firstWhere(
          (char) => char.docID == currentID,
          orElse: () => characters.first,
        ),
      ),
    );
  }
}

void signOutFlow(SignInMethod method) async {
  var inst = await _googleSignIn;
  switch (method) {
    case SignInMethod.Google:
      unawaited(inst.signOut());
  }

  dwStore.dispatch(UserActions.logout());
  dwStore.dispatch(CharacterActions.remove());
}

Future<ExposedAuthCredential> signInWithGoogle() async {
  try {
    var inst = await _googleSignIn;
    GoogleSignInAccount googleUser = await inst.signInSilently();

    if (googleUser == null) {
      googleUser = await inst.signIn();
      if (googleUser == null) throw 'google_user_error';
    }

    var googleAuth = await googleUser.authentication;
    print('googleAuth: $googleAuth');
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
