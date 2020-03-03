import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/refactor/character.dart';
import 'package:meta/meta.dart';

class CharacterStore {
  String currentCharDocID;
  Character current;
  Map<String, Character> characters;

  CharacterStore({currentCharDocID, @required characters, current}) {
    if (current == null && characters != null && characters.isNotEmpty) {
      current = characters[characters.data.first];
      currentCharDocID = characters.data.first;
    }
  }
}

CharacterStore characterReducer(CharacterStore state, action) {
  if (action is SetCharacters) {
    state.characters = action.characters;
    if (action.characters.isNotEmpty &&
        !state.characters.containsKey(state.currentCharDocID)) {
      state.currentCharDocID = action.characters.keys.first;
    }
    state.current = action.characters[state.currentCharDocID];
    return state;
  }

  if (action is SetCurrentChar) {
    state.currentCharDocID = action.id;
    state.characters[state.currentCharDocID] = action.character;
    state.current = action.character;
    return state;
  }

  if (action is RemoveAll) {
    return CharacterStore(
        current: null,
        currentCharDocID: null,
        characters: Map<String, Character>());
  }

  return state;
}
