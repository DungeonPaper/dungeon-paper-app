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

  void setCurrent(User value, [bool updateCondition = true]) {
    _current.value = value;
    update(null, updateCondition);
  }

  void setFirebaseUser(fb.User value, [bool updateCondition = true]) {
    _firebaseUser.value = value;
    update(null, updateCondition);
  }

  void login({
    User user,
    fb.User firebaseUser,
    bool updateCondition = true,
  }) {
    setCurrent(user, false);
    setFirebaseUser(firebaseUser, false);
    update(null, updateCondition);
  }

  void clear([bool updateCondition = true]) {
    setCurrent(null, false);
    setFirebaseUser(null, false);
    characterController.clear(false);
    update(null, updateCondition);
  }

  void logout([bool updateCondition = true]) => clear(updateCondition);
  void noLogin([bool updateCondition = true]) => clear(updateCondition);
}

UserController userReducer(UserController state, action) {
  if (action is Login) {
    return state
      ..setCurrent(action.user)
      ..setFirebaseUser(action.firebaseUser);
  }

  if (action is SetUser) {
    return state..setCurrent(action.user);
  }

  if (action is SetFirebaseUser) {
    return state..setFirebaseUser(action.user);
  }

  if (action is Logout || action is NoLogin) {
    return state
      ..setCurrent(null)
      ..setFirebaseUser(null);
  }

  return state;
}

final userController = UserController();
