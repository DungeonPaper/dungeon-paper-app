import 'package:dungeon_paper/db/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:meta/meta.dart';

part 'user_actions.dart';

class UserStore {
  String currentUserDocID;
  User current;
  fb.User firebaseUser;

  UserStore({
    @required this.currentUserDocID,
    @required this.current,
    @required this.firebaseUser,
  });
}

UserStore userReducer(UserStore state, action) {
  if (action is Login) {
    return UserStore(
      currentUserDocID: action.user.documentID,
      current: action.user,
      firebaseUser: action.firebaseUser,
    );
  }

  if (action is SetUser) {
    return state
      ..current = action.user
      ..currentUserDocID = action.user.documentID;
  }

  if (action is SetFirebaseUser) {
    return state..firebaseUser = action.user;
  }

  if (action is Logout || action is NoLogin) {
    return UserStore(currentUserDocID: null, current: null, firebaseUser: null);
  }

  return state;
}
