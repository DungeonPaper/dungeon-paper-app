import 'package:dungeon_paper/db/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show required;
export 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class UserLogin {
  final FirebaseUser firebaseUser;
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
