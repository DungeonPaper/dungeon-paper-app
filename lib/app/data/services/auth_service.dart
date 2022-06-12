import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends GetxService with UserServiceMixin {
  FirebaseAuth get auth => FirebaseAuth.instance;

  Future<UserCredential> loginWithPassword({
    required String email,
    required String password,
  }) async =>
      auth.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> loginWithGoogle() async {
    final gUser = await GoogleSignIn.standard().signIn();
    if (gUser == null) {
      throw StateError('user_cancel');
    }
    final gAuth = await gUser.authentication;
    return auth.signInWithCredential(
      GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
        accessToken: gAuth.accessToken,
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    auth.userChanges().listen((user) {
      debugPrint('user changed $user');

      if (user != null) {
        userService.loadUserData(user);
      } else {
        userService.loadGuestData();
      }
    });
  }
}

mixin AuthServiceMixin {
  AuthService get authService => Get.find();
}
