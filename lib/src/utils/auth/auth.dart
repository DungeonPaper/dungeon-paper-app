import 'package:dungeon_paper/db/listeners.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pedantic/pedantic.dart';
import '../api.dart';
import '../credentials.dart';
import '../utils.dart';
import 'auth_common.dart';

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

Future<FirebaseUser> signInFlow(
  CredentialsOld_ creds, {
  bool silent = false,
  bool interactiveOnFailSilent = true,
}) async {
  var providerCreds = creds.providerCredentials;
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

  final user = await getDatabaseUser(
    fbUser,
    signInMethod: creds.providerCredentials.providerId,
  );

  dispatchFinalDataToStore(
    credentials: creds,
    firebaseUser: fbUser,
    user: user,
  );

  return fbUser;
}

void registerAllListeners(FirebaseUser fbUser) {
  registerFirebaseUserListener();
  registerUserListener(fbUser);
  registerCharactersListener();
  registerCustomClassesListener();
}

void dispatchFinalDataToStore({
  @required CredentialsOld_ credentials,
  @required FirebaseUser firebaseUser,
  @required User user,
}) async {
  if (firebaseUser == null || credentials == null || user == null) {
    dwStore.dispatch(NoLogin());
    return;
  }

  // dwStore.dispatch(Login(
  //   user: user,
  //   // credentials: credentials,
  //   firebaseUser: firebaseUser,
  // ));

  unawaited(analytics.logLogin(
      loginMethod: credentials.providerCredentials.providerId));
  unawaited(analytics.setUserId(firebaseUser.uid));
  unawaited(analytics.setUserProperty(
    name: 'document_id',
    value: user.documentID,
  ));
  unawaited(analytics.setUserProperty(
    name: 'is_tester',
    value: user.isTester.toString(),
  ));
  registerAllListeners(firebaseUser);
}

void signOutFlow() async {
  var creds = dwStore.state.prefs.credentials;
  unawaited(auth.signOut());
  unawaited(creds.signOut());
  dwStore.dispatch(Logout());
  dwStore.dispatch(ClearCharacters());
}

Future<CredentialsOld_> signInWithGoogle({
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
        logger.e(e);
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
    logger.e(e);
    return null;
  }
}

Future<GoogleSignInAccount> signOutWithGoogle() async {
  var gInstance = await _googleSignIn;
  return await gInstance.signOut();
}

Future<FirebaseUser> getFirebaseUser(AuthCredential creds) async {
  try {
    var persistedUser = await auth.currentUser();

    if (persistedUser != null) {
      return persistedUser;
    }

    var result = await auth.signInWithCredential(creds);
    var user = result.user;
    return user;
  } catch (e) {
    logger.e(e);
    return null;
  }
}

class SignInError implements Exception {
  final String message;
  const SignInError([this.message]);

  @override
  String toString() {
    return '$runtimeType($message)';
  }
}
