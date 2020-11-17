import 'package:meta/meta.dart';
import 'package:dungeon_paper/db/models/character.dart';

part 'character_actions.dart';

class CharacterStore {
  Character current;
  Map<String, Character> all;

  CharacterStore({@required characters, this.current}) {
    if (current == null && characters?.isNotEmpty == true) {
      current = characters[characters.data.first];
    }
  }
}

CharacterStore characterReducer(CharacterStore state, action) {
  state.all ??= {};

  if (action is SetCharacters) {
    state.all = action.characters;

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
    return CharacterStore(current: null, characters: <String, Character>{});
  }

  return state;
}
