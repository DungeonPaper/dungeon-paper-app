import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions/action.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';

enum UserActionTypes { Login, Logout, Loading }

class UserActions {
  static Action login(String id, DbUser data) {
    return Action(
      type: UserActionTypes.Login,
      payload: UserStore(id: id, user: data),
    );
  }

  static Action logout() {
    return Action(
      type: UserActionTypes.Login,
    );
  }
}
