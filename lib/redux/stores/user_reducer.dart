import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions/user_actions.dart';
import 'package:meta/meta.dart';

class UserStore {
  String currentUserDocID;
  DbUser current;

  UserStore({@required this.currentUserDocID, @required this.current});
}

UserStore userReducer(UserStore state, action) {
  if (action is Login) {
    return UserStore(
      currentUserDocID: action.id,
      current: action.user,
    );
  }

  if (action is Logout || action is NoLogin) {
    return UserStore(currentUserDocID: null, current: null);
  }

  return state;
}
