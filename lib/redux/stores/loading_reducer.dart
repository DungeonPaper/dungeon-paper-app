import 'package:dungeon_paper/redux/actions/character_actions.dart';
import 'package:dungeon_paper/redux/actions/user_actions.dart';

enum LoadingKeys {
  User,
  Character,
}

Map<LoadingKeys, bool> loadingReducer(Map<LoadingKeys, bool> state, action) {
  if (action is RequestLogin) {
    state[LoadingKeys.Character] = true;
    state[LoadingKeys.User] = true;
    return state;
  }

  if (action is SetCurrentChar) {
    state[LoadingKeys.Character] = false;
    return state;
  }

  if (action is Login || action is NoLogin) {
    state[LoadingKeys.User] = false;
  }

  return state;
}
