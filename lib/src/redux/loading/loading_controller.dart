import 'package:dungeon_paper/src/redux/characters/characters_controller.dart';
import 'package:dungeon_paper/src/redux/custom_classes/custom_classes_controller.dart';
import 'package:dungeon_paper/src/redux/users/user_controller.dart';
import 'package:get/get.dart';

enum LoadingKeys {
  user,
  character,
  customClasses,
}

class LoadingController extends GetxController {
  final RxMap<LoadingKeys, bool> _data = <LoadingKeys, bool>{
    LoadingKeys.user: true,
    LoadingKeys.character: true,
  }.obs;

  bool operator [](key) {
    if (key is! LoadingKeys) {
      throw FormatException(
          'Expected LoadingKeys, ${key.runtimeType} given', key, 0);
    }

    return _data[key] == true;
  }

  void requestLogin([bool updateCondition = true]) {
    _data[LoadingKeys.character] = true;
    _data[LoadingKeys.user] = true;
    update(null, updateCondition);
  }

  void login([bool updateCondition = true]) {
    _data[LoadingKeys.user] = false;
    update(null, updateCondition);
  }

  void noLogin([bool updateCondition = true]) {
    _data[LoadingKeys.character] = false;
    _data[LoadingKeys.user] = false;
    update(null, updateCondition);
  }

  void upsertCharacter([bool updateCondition = true]) {
    _data[LoadingKeys.character] = false;
    update(null, updateCondition);
  }

  void setUser([bool updateCondition = true]) {
    _data[LoadingKeys.user] = false;
    update(null, updateCondition);
  }

  void getCustomClasses([bool updateCondition = true]) {
    _data[LoadingKeys.customClasses] = true;
    update(null, updateCondition);
  }

  void setCustomClasses([bool updateCondition = true]) {
    _data[LoadingKeys.customClasses] = false;
    update(null, updateCondition);
  }
}

Map<LoadingKeys, bool> loadingReducer(Map<LoadingKeys, bool> state, action) {
  if (action is RequestLogin) {
    state[LoadingKeys.character] = true;
    state[LoadingKeys.user] = true;
    return state;
  }

  if (action is SetCurrentChar) {
    state[LoadingKeys.character] = false;
    return state;
  }

  if (action is SetUser) {
    state[LoadingKeys.user] = false;
    return state;
  }

  if (action is SetCharacters || action is UpsertCharacter) {
    state[LoadingKeys.character] = false;
    return state;
  }

  if (action is Login) {
    state[LoadingKeys.user] = false;
    return state;
  }

  if (action is NoLogin) {
    state[LoadingKeys.character] = false;
    state[LoadingKeys.user] = false;
    return state;
  }

  if (action is GetCustomClasses) {
    state[LoadingKeys.customClasses] = true;
    return state;
  }

  return state;
}

final loadingController = LoadingController();
