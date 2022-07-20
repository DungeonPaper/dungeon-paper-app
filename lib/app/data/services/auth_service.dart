import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends GetxService
    with UserServiceMixin, LoadingServiceMixin, RepositoryServiceMixin {
  FirebaseAuth get auth => FirebaseAuth.instance;
  final gSignIn = GoogleSignIn.standard();

  Future<UserCredential> loginWithPassword({
    required String email,
    required String password,
  }) async =>
      auth.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> loginWithGoogle() async {
    final gUser = await gSignIn.signIn();
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

  logout() {
    auth.signOut();
    gSignIn.signOut();
  }

  @override
  void onInit() {
    super.onInit();

    auth.userChanges().listen((user) {
      debugPrint('user changed $user');

      if (user != null) {
        loadingService.loadingCharacters = !loadingService.afterFirstLoad;
        loadingService.afterFirstLoad = false;
        userService.loadUserData(user);
        return;
      }

      userService.loadGuestData();
    });
  }
}

mixin AuthServiceMixin {
  AuthService get authService => Get.find();
}
