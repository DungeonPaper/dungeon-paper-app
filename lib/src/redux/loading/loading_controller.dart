import 'package:dungeon_paper/src/redux/characters/characters_controller.dart';
import 'package:dungeon_paper/src/redux/custom_classes/custom_classes_store.dart';
import 'package:dungeon_paper/src/redux/users/user_controller.dart';
import 'package:get/get.dart';

enum LoadingKeys {
  user,
  character,
  customClasses,
}

class LoadingController extends GetxController {
  final RxMap<LoadingKeys, bool> _data = {}.obs;

  bool operator [](key) {
    if (key is! LoadingKeys) {
      throw FormatException(
          'LoadingKeys must be given as property accessor, ${key.runtimeType} give instead',
          key,
          0);
    }

    return _data[key];
  }

  void requestLogin() {
    _data[LoadingKeys.character] = true;
    _data[LoadingKeys.user] = true;
    update();
  }

  void login() {
    _data[LoadingKeys.user] = false;
    update();
  }

  void noLogin() {
    _data[LoadingKeys.character] = false;
    _data[LoadingKeys.user] = false;
    update();
  }

  void upsertCharacter() {
    _data[LoadingKeys.character] = false;
    update();
  }

  void setUser() {
    _data[LoadingKeys.user] = false;
    update();
  }

  void getCustomClasses() {
    _data[LoadingKeys.customClasses] = true;
    update();
  }

  void setCustomClasses() {
    _data[LoadingKeys.customClasses] = false;
    update();
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
