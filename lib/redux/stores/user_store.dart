import 'package:dungeon_paper/redux/actions/user_actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:redux/redux.dart';

UserStore userReducer(UserStore state, dynamic action) {
  switch (action.type) {
    case (UserActionTypes.Login):
      return action.payload;

    case (UserActionTypes.Logout):
      return null;
  }

  return state;
}

Store<UserStore> userStore = new Store(
  userReducer,
  initialState: UserStore(id: null, user: null),
);
