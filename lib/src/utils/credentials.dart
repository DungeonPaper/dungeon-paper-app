import 'package:dungeon_paper/src/utils/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

abstract class Credentials<T extends AuthCredential> {
  T providerCredentials;
  final Map<String, String> _map;

  Credentials({
    Map<String, String> data,
    this.providerCredentials,
  }) : _map = data;

  bool get isEmpty =>
      _map == null ||
      _map.isEmpty ||
      _map.values.any((v) => v == null) ||
      providerCredentials == null;

  bool get isNotEmpty => !isEmpty;

  Future<Credentials> signIn({
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
      print(e);
      rethrow;
    } catch (e) {
      print('Unexpected error:');
      rethrow;
    }
  }

  Future<Credentials> _signIn({
    @required bool attemptSilent,
    @required bool interactiveOnFailSilent,
  });

  Future<void> signOut();

  Map<String, String> serialize() => _map;
}

class GoogleCredentials extends Credentials<GoogleAuthCredential> {
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
          GoogleAuthCredential credential) =>
      GoogleCredentials(
        providerCredentials: credential,
        data: {
          'idToken': credential.idToken,
          'accessToken': credential.accessToken,
        },
      );

  @override
  Future<Credentials> _signIn({
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

  // AuthCredential get googleCredentials => GoogleAuthCredential(
  //       accessToken: accessToken,
  //       idToken: idToken,
  //     );
}
