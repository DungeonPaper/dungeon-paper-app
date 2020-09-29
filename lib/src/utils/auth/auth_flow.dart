import 'package:dungeon_paper/db/listeners.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/api.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pedantic/pedantic.dart';
import 'auth_common.dart';

Future<UserLogin> signInWithCredentials(AuthCredential creds) async {
  assert(creds != null);
  dwStore.dispatch(RequestLogin());

  var res = await auth.signInWithCredential(creds);
  return signInWithFbUser(res?.user);
}

Future<UserLogin> signInWithEmailAndPassword({
  @required String email,
  @required String password,
}) async {
  dwStore.dispatch(RequestLogin());

  var res = await auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  return signInWithFbUser(res?.user);
}

Future<UserLogin> createUserWithEmailAndPassword({
  @required String email,
  @required String password,
}) async {
  assert(email != null && password != null);
  dwStore.dispatch(RequestLogin());

  var res = await auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  return signInWithFbUser(res?.user);
}

GoogleSignIn _gSignIn;
Future<GoogleSignIn> _getGSignIn() async {
  if (_gSignIn != null) {
    return _gSignIn;
  }
  var secrets = await loadSecrets();
  return _gSignIn = kIsWeb
      ? GoogleSignIn(clientId: secrets.GOOGLE_CLIENT_ID)
      : GoogleSignIn();
}

Future<UserLogin> signInWithGoogle({@required bool interactive}) async {
  dwStore.dispatch(RequestLogin());
  var inst = await _getGSignIn();
  var acct = await (interactive ? inst.signIn() : inst.signInSilently());
  var authRes = await acct.authentication;
  var cred = GoogleAuthProvider.getCredential(
    accessToken: authRes.accessToken,
    idToken: authRes.idToken,
  );
  var res = await auth.signInWithCredential(cred);
  return signInWithFbUser(res?.user);
}

Future<UserLogin> signInAutomatically() async {
  return signInWithFbUser(await auth.currentUser());
}

Future<UserLogin> signInWithFbUser(FirebaseUser fbUser) async {
  final dbUser = await getDatabaseUser(
    fbUser,
    signInMethod: fbUser?.providerId,
  );

  dispatchFinalDataToStore(
    firebaseUser: fbUser,
    user: dbUser,
  );

  return UserLogin(
    firebaseUser: fbUser,
    user: dbUser,
  );
}

Future<void> signOutAll() {
  dwStore.dispatch(Logout());
  _gSignIn?.disconnect();
  return auth.signOut();
}

void dispatchFinalDataToStore({
  @required FirebaseUser firebaseUser,
  @required User user,
}) async {
  if ([firebaseUser, user].any((el) => el == null)) {
    dwStore.dispatch(NoLogin());
    return;
  }

  dwStore.dispatch(Login(
    user: user,
    firebaseUser: firebaseUser,
  ));

  unawaited(analytics.logLogin(
    loginMethod: firebaseUser.providerId,
  ));
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

void registerAllListeners(FirebaseUser fbUser) {
  registerFirebaseUserListener();
  registerUserListener(fbUser);
  registerCharactersListener();
  registerCustomClassesListener();
}
