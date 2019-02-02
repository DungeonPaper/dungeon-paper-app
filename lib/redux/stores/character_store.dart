import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/actions/character_actions.dart';
import 'package:meta/meta.dart';

class CharacterStore {
  String currentCharDocID;
  DbCharacter current;
  Map<String, DbCharacter> characters;

  CharacterStore({this.currentCharDocID, @required this.characters, this.current}) {
    if (this.current == null) {
      this.current = this.characters[this.characters.keys.first];
      this.currentCharDocID = this.characters.keys.first;
    }
  }
}

CharacterStore characterReducer(CharacterStore state, action) {
  if (action is SetCurrentChar) {
    state.currentCharDocID = action.id;
    state.characters[state.currentCharDocID] = action.character;
    return state;
  }

  if (action is UpdateField) {
    state.characters[state.currentCharDocID].set(action.field, action.value);
    return state;
  }

  if (action is RemoveAll) {
    return CharacterStore(current: DbCharacter(), currentCharDocID: '', characters: Map<String, DbCharacter>());
  }

  return state;
}
