import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:dungeon_paper/db/listeners.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/api.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pedantic/pedantic.dart';
import 'auth_common.dart';
part 'auth_email.dart';
part 'auth_google.dart';
part 'auth_apple.dart';

Future<UserLogin> signInWithCredentials(AuthCredential creds) async {
  assert(creds != null);
  dwStore.dispatch(RequestLogin());

  final res = await auth.signInWithCredential(creds);
  return signInWithFbUser(res?.user);
}

Future<bool> linkWithCredentials(AuthCredential creds) async {
  final user = await auth.currentUser();
  try {
    await user.linkWithCredential(creds);
    return true;
  } on PlatformException catch (e) {
    if (e.code == 'ERROR_REQUIRES_RECENT_LOGIN') {
      AuthCredential creds;
      final firstNonFbProvider = user.providerData.firstWhere(
        (data) => data.providerId != 'firebase',
        orElse: () => null,
      );
      switch (firstNonFbProvider.providerId) {
        case 'google.com':
          creds = await getGoogleCredential(interactive: true);
          break;
        case 'apple.id':
          creds = await getAppleCredential(interactive: true);
          break;
        default:
          throw Exception('Unimplemented provider method');
      }
      await user.reauthenticateWithCredential(creds);
      await user.linkWithCredential(creds);
      return true;
    }
    rethrow;
  } catch (e, stack) {
    logger.w('Could not link with credential: $creds', e, stack);
    return false;
  }
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
