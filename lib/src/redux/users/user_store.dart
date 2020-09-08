import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/utils/auth/credentials/auth_credentials.dart';
import 'package:dungeon_paper/src/utils/credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'user_actions.dart';

class UserStore {
  String currentUserDocID;
  User current;
  FirebaseUser firebaseUser;

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

  if (action is Logout || action is NoLogin) {
    return UserStore(currentUserDocID: null, current: null, firebaseUser: null);
  }

  return state;
}
