import 'package:dungeon_paper/db/listeners.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/db/models/user_with_characters.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pedantic/pedantic.dart';
import 'api.dart';
import 'credentials.dart';
import 'utils.dart';

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

Future<FirebaseUser> signInFlow(
  Credentials creds, {
  bool silent = false,
  bool interactiveOnFailSilent = true,
}) async {
  AuthCredential providerCreds = creds.providerCredentials;

  dwStore.dispatch(RequestLogin());
  var user = await getFirebaseUser(providerCreds);

  if (user == null) {
    creds = await creds.signIn(
      attemptSilent: silent,
      interactiveOnFailSilent: interactiveOnFailSilent,
    );
    if (creds == null || creds.isEmpty) {
      throw SignInError('credentials_empty');
    }
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
    dwStore.dispatch(NoLogin());
    return;
  }

  var prefs = dwStore.state.prefs;
  var user = User(
      data: dbLoginData.toJSON()..remove('characters'), ref: dbLoginData.ref);
  var characters = dbLoginData.characters;

  dwStore.dispatch(Login(
    user: user,
    credentials: credentials,
    firebaseUser: firebaseUser,
  ));

  dwStore.dispatch(
    SetCharacters({
      for (var char in characters) char.docID: char,
    }),
  );

  if (characters.isNotEmpty) {
    var currentID = prefs.user.lastCharacterId ?? characters.first.docID;
    dwStore.dispatch(
      SetCurrentChar(
        characters.firstWhere(
          (char) => char.docID == currentID,
          orElse: () => characters.first,
        ),
      ),
    );
  }
}

void signOutFlow() async {
  var creds = dwStore.state.prefs.credentials;
  unawaited(_auth.signOut());
  unawaited(creds.signOut());
  dwStore.dispatch(Logout());
  dwStore.dispatch(ClearCharacters());
}

Future<Credentials> signInWithGoogle({
  bool silent,
  bool interactiveOnFailSilent,
}) async {
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

    if (googleUser == null && (!silent || interactiveOnFailSilent)) {
      googleUser = await gInstance.signIn();
    }

    if (googleUser == null) {
      throw SignInError('google_sign_in_error');
    }

    var googleAuth = await googleUser.authentication;

    return GoogleCredentials.fromAuthCredential(
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

Future<GoogleSignInAccount> signOutWithGoogle() async {
  var gInstance = await _googleSignIn;
  return await gInstance.signOut();
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

class SignInError extends Error {
  final String message;
  SignInError(this.message);
}