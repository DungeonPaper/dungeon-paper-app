import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService extends GetxService
    with UserServiceMixin, LoadingServiceMixin, RepositoryServiceMixin {
  FirebaseAuth get auth => FirebaseAuth.instance;
  final gSignIn = GoogleSignIn.standard();
  final fbUser = Rx<User?>(null);

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

  Future<UserCredential> loginWithApple() async {
    final cred = await SignInWithApple.getAppleIDCredential(
      // webAuthenticationOptions: WebAuthenticationOptions(
      //   clientId: 'clientId',
      //   redirectUri: Uri.parse(
      //       'intent://callback?${PARAMETERS_FROM_CALLBACK_BODY}#Intent;package=YOUR.PACKAGE.IDENTIFIER;scheme=signinwithapple;end'),
      // ),
      // webAuthenticationOptions: WebAuthenticationOptions(
      //   clientId: 'app.dungeonpaper',
      //   redirectUri:
      //       // kIsWeb
      //       //     ? Uri.parse('https://${window.location.host}/'):
      //       Uri.parse(
      //     'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
      //   ),
      // ),
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
      idToken: cred.identityToken,
      accessToken: cred.authorizationCode,
    );

    return auth.signInWithCredential(credential);
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
      fbUser.value = user;

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
