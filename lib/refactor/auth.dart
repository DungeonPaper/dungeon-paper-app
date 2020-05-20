import 'package:dungeon_paper/db/listeners.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/prefs_store.dart';
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

Future<FirebaseUser> signInFlow(Credentials creds) async {
  AuthCredential providerCreds = creds.providerCredentials;

  dwStore.dispatch(UserActions.requestLogin());
  var user = await getFirebaseUser(providerCreds);

  if (user == null) {
    creds = await creds.refresh();
    providerCreds = creds.providerCredentials;
    user = await getFirebaseUser(providerCreds);
  }

  final loginResult = await doApiLogin(user, creds);

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
  @required Credentials credentials,
  @required FirebaseUser firebaseUser,
  @required UserWithChildren dbLoginData,
}) async {
  if (firebaseUser == null || credentials == null || dbLoginData == null) {
    dwStore.dispatch(UserActions.noLogin());
    return;
  }

  var prefs = dwStore.state.prefs;
  var user = User(
      data: dbLoginData.toJSON()..remove('characters'), ref: dbLoginData.ref);
  var characters = dbLoginData.characters;

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

Future<Credentials> signInWithGoogle({bool silent = true}) async {
  try {
    var gInstance = await _googleSignIn;
    GoogleSignInAccount googleUser;
    if (silent == true) {
      try {
        googleUser = await gInstance.signInSilently();
      } catch (e) {
        print(e);
      }
    }

    if (googleUser == null) {
      googleUser = await gInstance.signIn();
      if (googleUser == null) {
        throw 'google_user_error';
      }
    }

    var googleAuth = await googleUser.authentication;

    return Credentials.fromAuthCredential(
      GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      ),
    );
  } catch (e) {
    print(e);
    return null;
  }
}

Future<FirebaseUser> getFirebaseUser(AuthCredential creds) async {
  try {
    var result = await _auth.signInWithCredential(creds);
    var user = result.user;
    return user;
  } catch (e) {
    print(e);
    return null;
  }
}
