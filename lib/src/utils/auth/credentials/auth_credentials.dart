import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/utils/auth/auth_flow.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth_common.dart';

part 'google_credentials.dart';
part 'email_credentials.dart';

enum SignInMethod {
  Google,
  Email,
}

const signInMethodKeys = {
  'google': SignInMethod.Google,
  'email': SignInMethod.Email,
};

abstract class Credentials<T extends AuthCredential> {
  Credentials({
    this.providerCredentials,
    @required this.data,
  })  : assert(SignInMethod.values
            .every((m) => signInMethodKeys.values.contains(m))),
        assert(data != null);

  factory Credentials.fromStorage(
      String providerName, Map<String, String> data) {
    SignInMethod provider;
    try {
      provider = stringToEnum(providerName, signInMethodKeys);
    } catch (_) {
      provider = null;
    }
    switch (provider) {
      case SignInMethod.Email:
        // assert(data['email'] != null && data['password'] != null);
        return EmailCredentials.fromAuthCredential(
          EmailAuthCredential(
            email: data['email'],
            password: data['password'],
          ),
        ) as Credentials<T>;
      case SignInMethod.Google:
      default:
        // assert(data['idToken'] != null && data['accessToken'] != null);
        return GoogleCredentials.fromAuthCredential(
          GoogleAuthCredential(
            idToken: data['idToken'],
            accessToken: data['accessToken'],
          ),
        ) as Credentials<T>;
    }
  }

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
