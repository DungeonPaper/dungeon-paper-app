import 'package:dungeon_paper/src/utils/auth/auth.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

abstract class CredentialsOld_<T extends AuthCredential> {
  T providerCredentials;
  final Map<String, String> _map;

  CredentialsOld_({
    Map<String, String> data,
    this.providerCredentials,
  }) : _map = data;

  bool get isEmpty =>
      _map == null ||
      _map.isEmpty ||
      (kIsWeb
          ? _map.values.every((v) => v == null)
          : _map.values.any((v) => v == null)) ||
      providerCredentials == null;

  bool get isNotEmpty => !isEmpty;

  Future<CredentialsOld_> signIn({
    @required bool attemptSilent,
    @required bool interactiveOnFailSilent,
  }) {
    if (isEmpty && attemptSilent) {
      throw SignInError('credentials_empty');
    }
    try {
      var result = _signIn(
        attemptSilent: attemptSilent,
        interactiveOnFailSilent: interactiveOnFailSilent,
      );
      return result;
    } on SignInError catch (e) {
      logger.e(e);
      rethrow;
    } catch (e) {
      print('Unexpected error:');
      rethrow;
    }
  }

  Future<CredentialsOld_> _signIn({
    @required bool attemptSilent,
    @required bool interactiveOnFailSilent,
  });

  Future<void> signOut();

  Map<String, String> serialize() => _map;
}

class GoogleCredentials extends CredentialsOld_<GoogleAuthCredential> {
  GoogleCredentials({
    Map<String, String> data,
    GoogleAuthCredential providerCredentials,
  }) : super(
          data: data,
          providerCredentials: providerCredentials,
        );

  String get idToken => _map['idToken'];
  String get accessToken => _map['accessToken'];

  factory GoogleCredentials.fromAuthCredential(
    GoogleAuthCredential credential,
  ) =>
      GoogleCredentials(
        providerCredentials: credential,
        data: {
          'idToken': credential.idToken,
          'accessToken': credential.accessToken,
        },
      );

  @override
  Future<CredentialsOld_> _signIn({
    @required bool attemptSilent,
    @required bool interactiveOnFailSilent,
  }) =>
      signInWithGoogle(
        silent: attemptSilent,
        interactiveOnFailSilent: interactiveOnFailSilent,
      );

  @override
  Future<void> signOut({
    @required bool attemptSilent,
    @required bool interactiveOnFailSilent,
  }) =>
      signOutWithGoogle();
}

class EmailCredentials extends CredentialsOld_<EmailAuthCredential> {
  EmailCredentials({
    Map<String, String> data,
    EmailAuthCredential providerCredentials,
  }) : super(
          data: data,
          providerCredentials: providerCredentials,
        );

  String get idToken => _map['idToken'];
  String get accessToken => _map['accessToken'];

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
  Future<CredentialsOld_> _signIn({
    @required bool attemptSilent,
    @required bool interactiveOnFailSilent,
  }) =>
      signInWithGoogle(
        silent: attemptSilent,
        interactiveOnFailSilent: interactiveOnFailSilent,
      );

  @override
  Future<void> signOut({
    @required bool attemptSilent,
    @required bool interactiveOnFailSilent,
  }) =>
      signOutWithGoogle();
}
