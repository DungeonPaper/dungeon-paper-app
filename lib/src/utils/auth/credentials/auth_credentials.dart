import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../auth_common.dart';

abstract class Credentials<T extends AuthCredential> {
  Credentials({
    this.providerCredentials,
    this.data,
  });

  T providerCredentials;
  Map<String, String> data;

  bool get isEmpty;
  bool get isNotEmpty => !isEmpty;

  Future<Credentials<AuthCredential>> platformSignIn({
    @required bool interactive,
  });

  Future<FirebaseUser> signIn({
    @required bool interactive,
  }) async {
    FirebaseUser fbUser;
    if (isNotEmpty) {
      fbUser = await firebaseUser;
    }

    if (fbUser == null) {
      var cred = await platformSignIn(interactive: interactive);
      if (cred == null || cred.isEmpty) {
        throw SignInError('credentials_empty');
      }
      fbUser = await cred.firebaseUser;
      if (fbUser == null) {
        throw SignInError('credentials_error');
      }

      return fbUser;
    }

    return fbUser;
  }

  Future<FirebaseUser> get firebaseUser async {
    try {
      var persistedUser = await auth.currentUser();

      if (persistedUser != null) {
        return persistedUser;
      }

      var result = await auth.signInWithCredential(providerCredentials);
      var user = result.user;
      return user;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<void> signOut();

  Map<String, String> serialize() => data;
}

class UserLogin {
  FirebaseUser firebaseUser;
  User user;

  UserLogin({
    @required this.firebaseUser,
    @required this.user,
  });
}
