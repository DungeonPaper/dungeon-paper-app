import 'package:dungeon_paper/src/utils/auth/auth_common.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'auth_credentials.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

class EmailCredentials extends Credentials<EmailAuthCredential> {
  EmailCredentials({
    Map<String, String> data,
    EmailAuthCredential providerCredentials,
  }) : super(
          data: data,
          providerCredentials: providerCredentials,
        );

  String get idToken => data['idToken'];
  String get accessToken => data['accessToken'];

  factory EmailCredentials.fromAuthCredential(
    EmailAuthCredential credential,
  ) =>
      EmailCredentials(
        providerCredentials: credential,
        data: {
          'email': credential.email,
          'password': credential.password,
        },
      );

  @override
  Future<Credentials<AuthCredential>> generateCredentials({
    @required bool interactive,
  }) async {
    try {
      if (isEmpty) {
        throw SignInError('credentials_empty');
      }

      return EmailCredentials.fromAuthCredential(
        EmailAuthProvider.getCredential(
          email: data['email'],
          password: data['password'],
        ),
      );
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  @override
  bool get isEmpty =>
      data['email']?.isNotEmpty == true && data['password']?.isNotEmpty == true;
}
