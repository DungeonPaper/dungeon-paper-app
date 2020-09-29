import 'package:dungeon_paper/db/listeners.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/api.dart';
import 'package:dungeon_paper/src/utils/auth/credentials/auth_credentials.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:pedantic/pedantic.dart';
import 'auth_common.dart';

Future<UserLogin> signInWithCredentials<T extends AuthCredential>(
  Credentials<T> creds, {
  bool interactive = true,
}) async {
  assert(creds != null);
  dwStore.dispatch(RequestLogin());

  var fbUser = await creds.signIn(interactive: interactive);

  final dbUser = await getDatabaseUser(
    fbUser,
    signInMethod: creds.providerCredentials.providerId,
  );

  dispatchFinalDataToStore(
    credentials: creds,
    firebaseUser: fbUser,
    user: dbUser,
  );

  return UserLogin(
    firebaseUser: fbUser,
    user: dbUser,
  );
}

Future<UserLogin> signInWithFbUser(
    FirebaseUser fbUser, Credentials creds) async {
  final dbUser = await getDatabaseUser(
    fbUser,
    signInMethod: creds.providerCredentials.providerId,
  );

  dispatchFinalDataToStore(
    credentials: creds,
    firebaseUser: fbUser,
    user: dbUser,
  );

  return UserLogin(
    firebaseUser: fbUser,
    user: dbUser,
  );
}

Future<void> signOutWithCredentials<T extends AuthCredential>(
    Credentials<T> creds) async {
  dwStore.dispatch(Logout());
  dwStore.dispatch(ClearCharacters());
  return creds.signOut();
}

Future<void> signOutAll() {
  var creds = dwStore.state.prefs.credentials;
  return signOutWithCredentials(creds);
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

void dispatchFinalDataToStore({
  @required Credentials credentials,
  @required FirebaseUser firebaseUser,
  @required User user,
}) async {
  if ([firebaseUser, credentials, user].any((el) => el == null)) {
    dwStore.dispatch(NoLogin());
    return;
  }

  dwStore.dispatch(Login(
    user: user,
    credentials: credentials,
    firebaseUser: firebaseUser,
  ));

  unawaited(analytics.logLogin(
    loginMethod: credentials.providerCredentials.providerId,
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
