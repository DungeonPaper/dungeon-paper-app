import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/redux/characters/characters_controller.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'user_actions.dart';

class UserController extends GetxController {
  final Rx<User> _current = Rx<User>();
  final Rx<fb.User> _firebaseUser = Rx<fb.User>();

  String get currentUserDocID => current.documentID;
  User get current => _current.value;
  fb.User get firebaseUser => _firebaseUser.value;

  bool get isLoggedIn => firebaseUser != null && current != null;

  set current(User value) {
    _current.value = value;
    update();
  }

  set firebaseUser(fb.User value) {
    _firebaseUser.value = value;
    update();
  }

  void login({
    User user,
    fb.User firebaseUser,
  }) {
    current = user;
    firebaseUser = firebaseUser;
    update();
  }

  void clear() {
    current = null;
    firebaseUser = null;
    characterController.clear();
    update();
  }

  void logout() => clear();
  void noLogin() => clear();
}

UserController userReducer(UserController state, action) {
  if (action is Login) {
    return state
      ..current = action.user
      ..firebaseUser = action.firebaseUser;
  }

  if (action is SetUser) {
    return state..current = action.user;
  }

  if (action is SetFirebaseUser) {
    return state..firebaseUser = action.user;
  }

  if (action is Logout || action is NoLogin) {
    return state
      ..current = null
      ..firebaseUser = null;
  }

  return state;
}

final userController = UserController();
