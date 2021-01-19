import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/redux/characters/characters_controller.dart';
import 'package:dungeon_paper/src/redux/custom_classes/custom_classes_store.dart';
import 'package:dungeon_paper/src/redux/loading/loading_controller.dart';
import 'package:dungeon_paper/src/redux/users/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:get/get.dart';

class AuthController extends GetxController {
  void requestLogin() {
    loadingController.requestLogin();
    userController.clear();
    update();
  }

  void login({
    User user,
    fb.User firebaseUser,
  }) {
    loadingController.login();
    userController.login(user: user, firebaseUser: firebaseUser);
    update();
  }

  void noLogin() {
    loadingController.noLogin();
    userController.clear();
    update();
  }

  void upsertCharacter(Character character) {
    loadingController.upsertCharacter();
    characterController.upsert(character);
    update();
  }

  void setUser(User user) {
    loadingController.setUser();
    userController.current = user;
    update();
  }

  void getCustomClasses() {
    loadingController.getCustomClasses();
    customClassesController.clear();
    update();
  }

  void setCustomClasses(Iterable<CustomClass> classes) {
    loadingController.setCustomClasses();
    customClassesController.setAll(classes);
    update();
  }

  void setFirebaseUser(fb.User user) {
    userController.firebaseUser = user;
  }

  void logout() => noLogin();
}

final authController = AuthController();
