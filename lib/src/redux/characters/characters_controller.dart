import 'package:get/get.dart';
import 'package:dungeon_paper/db/models/character.dart';

part 'character_actions.dart';

class CharacterController extends GetxController {
  final Rx<Character> _current = Rx();
  final RxMap<String, Character> all = {}.obs;

  Character get current => _current.value;

  set current(Character value) {
    if (current != null) {
      _current.value = value;
      update();
      return;
    }

    if (value == null) {
      _current.value = all.values.first;
      update();
    }
  }

  void upsert(Character character) {
    all[character.documentID] = character;
    if (current.documentID == character.documentID) {
      _current.value = character;
    }
    update();
  }

  void remove(Character character) {
    all.removeWhere((key, value) => character.documentID == value.documentID);
    if (current.documentID == character.documentID) {
      _current.value = all.values.first;
    }
    update();
  }

  void setAll(Iterable<Character> characters) {
    clear(false);
    all.assignAll({
      for (final char in characters) char.documentID: char,
    });
    if (current != null) {
      _current.value = all.values.firstWhere(
        (c) => c.documentID == current.documentID,
        orElse: () => null,
      );
    } else {
      _current.value = characters.first;
    }
    update();
  }

  void clear([bool updateCondition = true]) {
    all.removeWhere((_, __) => true);
    update(null, updateCondition);
  }
}

final characterController = CharacterController();

CharacterController characterReducer(CharacterController state, action) {
  state.all.assignAll({});

  if (action is SetCharacters) {
    state.all.assignAll(action.characters);

    if (state.current != null) {
      state.current = action.characters[state.current.documentID];
    } else if (action.characters.isNotEmpty &&
        !state.all.containsKey(state.current?.documentID)) {
      state.current = action.characters.values.first;
    }
    return state;
  }

  if (action is RemoveCharacter) {
    state.all.removeWhere((k, v) => k == action.character.documentID);
    if (state.current.documentID == action.character.documentID) {
      state.current = state.all.values.first;
    }
    return state;
  }

  if (action is UpsertCharacter) {
    state.all[action.character.documentID] = action.character;
    if (state.current?.documentID == action.character.documentID) {
      state.current = action.character;
    }
    return state;
  }

  if (action is SetCurrentChar) {
    state.current = action.character;
    return state;
  }

  if (action is ClearCharacters) {
    return CharacterController();
  }

  return state;
}
