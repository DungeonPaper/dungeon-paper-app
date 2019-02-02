import 'package:dungeon_paper/redux/actions/character_actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:redux/redux.dart';

CharacterStore characterReducer(CharacterStore state, dynamic action) {
  switch (action.type) {
    case (CharacterActionTypes.Change):
      return action.payload;

    case (CharacterActionTypes.SetField):
      state.character.set(action.payload['field'], action.payload['value']);
      return state;

    case (CharacterActionTypes.RemoveAll):
      return null;
  }

  return state;
}

Store<CharacterStore> characterStore = new Store(
  characterReducer,
  initialState: CharacterStore(id: null, character: null),
);
