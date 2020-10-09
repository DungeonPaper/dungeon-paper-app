import 'package:dungeon_paper/db/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart' show required;
export 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

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
