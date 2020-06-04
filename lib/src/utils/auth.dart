import 'package:dungeon_paper/db/listeners.dart';
import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/custom_classes/custom_classes_store.dart';
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
  FirebaseUser fbUser;

  dwStore.dispatch(RequestLogin());
  if (creds?.isNotEmpty == true) {
    fbUser = await getFirebaseUser(providerCreds);
  }

  if (fbUser == null) {
    creds = await creds.signIn(
      attemptSilent: silent,
      interactiveOnFailSilent: interactiveOnFailSilent,
    );
    if (creds == null || creds.isEmpty) {
      throw SignInError('credentials_empty');
    }
    providerCreds = creds.providerCredentials;
    fbUser = await getFirebaseUser(providerCreds);
  }

  final user = await doApiLogin(fbUser, creds);

  dispatchFinalDataToStore(
    credentials: creds,
    firebaseUser: fbUser,
    user: user,
  );

  registerAllListeners(fbUser);

  return fbUser;
}

void registerAllListeners(FirebaseUser fbUser) {
  registerFirebaseUserListener();
  registerUserListener(fbUser);
  registerCharactersListener();
}

void dispatchFinalDataToStore({
  @required Credentials credentials,
  @required FirebaseUser firebaseUser,
  @required User user,
}) async {
  if (firebaseUser == null || credentials == null || user == null) {
    dwStore.dispatch(NoLogin());
    return;
  }

  var prefs = dwStore.state.prefs;

  dwStore.dispatch(Login(
    user: user,
    credentials: credentials,
    firebaseUser: firebaseUser,
  ));

  final charactersData = {
    for (var char in user.characters)
      char.documentID: Character(ref: char, autoLoad: true),
  };

  final customClassesData = {
    for (var char in user.customClasses)
      char.documentID: CustomClass(ref: char, autoLoad: true),
  };

  if (charactersData.isNotEmpty) {
    var currentID = prefs.user.lastCharacterId ?? charactersData.keys.first;
    dwStore.dispatch(
      SetCurrentChar(
        charactersData.values.firstWhere(
          (char) => char.docID == currentID,
          orElse: () => charactersData.values.first,
        ),
      ),
    );
  }

  if (customClassesData.isNotEmpty) {
    dwStore.dispatch(SetCustomClasses(customClassesData));
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

class SignInError implements Exception {
  final String message;
  const SignInError([this.message]);
}
