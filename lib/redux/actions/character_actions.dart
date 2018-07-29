import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/actions/action.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';

enum CharacterActionTypes { Change, Remove, RemoveAll, Loading, SetField }

class CharacterActions {
  static Action updateChar(String id, DbCharacter data) {
    return Action(
      type: CharacterActionTypes.Change,
      payload: CharacterStore(id: id, character: data),
    );
  }

  static Action updateField(String field, dynamic value) {
    return Action(
      type: CharacterActionTypes.SetField,
      payload: {'field': field, 'value': value},
    );
  }

  static Action remove() {
    return Action(
      type: CharacterActionTypes.RemoveAll,
    );
  }
}
