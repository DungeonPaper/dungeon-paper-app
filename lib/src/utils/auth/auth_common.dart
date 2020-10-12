import 'package:dungeon_paper/db/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart' show required;
import 'package:dungeon_paper/src/utils/class_extensions/map_extensions.dart';
export 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

class SignInMethod {
  final String name;
  SignInMethod._(this.name);

  static final firebase = SignInMethod._('firebase');
  static final password = SignInMethod._('password');
  static final google = SignInMethod._('google.com');
  static final apple = SignInMethod._('apple.com');

  static SignInMethod fromCredential(fb.AuthCredential cred) =>
      _values.inverse[cred.providerId];

  static final _values = <SignInMethod, String>{
    SignInMethod.password: 'password',
    SignInMethod.google: 'google.com',
    SignInMethod.apple: 'apple.com',
  };

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
