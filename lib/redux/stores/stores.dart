import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores/characters_reducer.dart';
import 'package:dungeon_paper/redux/stores/loading_reducer.dart';
import 'package:dungeon_paper/redux/stores/user_reducer.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class DWStore {
  final UserStore user;
  final CharacterStore characters;
  final Map<LoadingKeys, bool> loading;

  DWStore(
      {@required this.user, @required this.characters, @required this.loading});
}

DWStore storeReducer(DWStore state, action) => DWStore(
      user: userReducer(state.user, action),
      characters: characterReducer(state.characters, action),
      loading: loadingReducer(state.loading, action),
    );

DWStore initialState = DWStore(
  loading: {LoadingKeys.Character: true, LoadingKeys.User: true},
  user: UserStore(current: null, currentUserDocID: null),
  characters: CharacterStore(
      currentCharDocID: null,
      current: null,
      characters: Map<String, DbCharacter>()),
);

Store<DWStore> dwStore =
    Store<DWStore>(storeReducer, initialState: initialState);
