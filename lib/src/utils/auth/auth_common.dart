import 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class SignInError implements Exception {
  final String message;
  const SignInError([this.message]);

  @override
  String toString() {
    return '$runtimeType($message)';
  }
}
