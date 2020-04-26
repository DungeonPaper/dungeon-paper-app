import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/refactor/character.dart';
import 'package:meta/meta.dart';

class CharacterStore {
  Character current;
  Map<String, Character> characters;

  CharacterStore({@required characters, this.current}) {
    if (current == null && characters != null && characters.isNotEmpty) {
      current = characters[characters.data.first];
    }
  }
}

CharacterStore characterReducer(CharacterStore state, action) {
  if (action is SetCharacters) {
    state.characters = action.characters;
    if (action.characters.isNotEmpty &&
        !state.characters.containsKey(state.current?.docID)) {
      state.current = action.characters.values.first;
    }
    return state;
  }

  if (action is AddCharacter) {
    state.characters = {
      ...state.characters,
      action.character.docID: action.character
    };
    return state;
  }

  if (action is RemoveCharacter) {
    state.characters.removeWhere((k, v) => k == action.character.docID);
    if (state.current.docID == action.character.docID) {
      state.current = state.characters.values.first;
    }
    return state;
  }

  if (action is UpdateCharacter) {
    state.characters[action.character.docID] = action.character;
    return state;
  }

  if (action is SetCurrentChar) {
    state.current = action.character;
    return state;
  }

  if (action is RemoveAll) {
    return CharacterStore(current: null, characters: Map<String, Character>());
  }

  return state;
}
