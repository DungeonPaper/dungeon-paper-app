import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/custom_classes/custom_classes_store.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';

enum LoadingKeys {
  User,
  Character,
  CustomClasses,
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

  if (action is SetUser) {
    state[LoadingKeys.User] = false;
    return state;
  }

  if (action is Login) {
    state[LoadingKeys.User] = false;
    state[LoadingKeys.Character] = false;
    return state;
  }

  if (action is NoLogin) {
    state[LoadingKeys.Character] = false;
    state[LoadingKeys.User] = false;
    return state;
  }

  if (action is GetCustomClasses) {
    state[LoadingKeys.CustomClasses] = true;
    return state;
  }

  return state;
}
