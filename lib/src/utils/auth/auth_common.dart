import 'package:dungeon_paper/db/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart' show required;
export 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

class SignInMethod {
  final String name;
  const SignInMethod._(this.name);

  static const firebase = SignInMethod._('firebase');
  static const password = SignInMethod._('password');
  static const google = SignInMethod._('google.com');
  static const apple = SignInMethod._('apple.com');

  factory SignInMethod.fromCredential(fb.AuthCredential cred) =>
      SignInMethod._(cred.providerId);

  factory SignInMethod.fromProviderId(String providerId) =>
      SignInMethod._(providerId);

  static List<SignInMethod> get values => _values.keys;

  static final _values = <SignInMethod, String>{
    SignInMethod.password: 'password',
    SignInMethod.google: 'google.com',
    SignInMethod.apple: 'apple.com',
  };

  @override
  bool operator ==(Object obj) =>
      (obj is SignInMethod && obj.name == name) || obj.toString() == name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => '$runtimeType.$name';
}

class UserLogin {
  final fb.User firebaseUser;
  final User user;

  UserLogin({
    @required this.firebaseUser,
    @required this.user,
  });
}

class SignInError implements Exception {
  final String message;
  const SignInError([this.message]);

  @override
  String toString() {
    return '$runtimeType($message)';
  }
}
