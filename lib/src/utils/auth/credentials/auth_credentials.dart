import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../auth_common.dart';

abstract class Credentials<T extends AuthCredential> {
  Credentials({
    this.providerCredentials,
    this.data,
  }) : assert(data != null);

  T providerCredentials;
  Map<String, String> data;

  bool get isEmpty;
  bool get isNotEmpty => !isEmpty;

  Future<FirebaseUser> signIn({
    @required bool interactive,
  }) async {
    FirebaseUser fbUser;

    if (isNotEmpty) {
      fbUser = await firebaseUser;
    }

    if (fbUser == null) {
      Credentials<AuthCredential> cred;

      try {
        cred = await generateCredentials(interactive: interactive);
      } catch (e) {
        logger.e(e);
        rethrow;
      }

      if (cred == null || cred.isEmpty) {
        throw SignInError('credentials_empty');
      }

      fbUser = await cred.firebaseUser;

      if (fbUser == null) {
        throw SignInError('no_fb_user');
      }

      return fbUser;
    }

    return fbUser;
  }

  Future<void> signOut() async {
    return auth.signOut();
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

  Future<Credentials<AuthCredential>> generateCredentials({
    @required bool interactive,
  });

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
