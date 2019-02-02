import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/stores/character_store.dart';
import 'package:dungeon_paper/redux/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class DWStore {
  final UserStore user;
  final CharacterStore characters;

  DWStore({@required this.user, @required this.characters});
}

DWStore storeReducer(DWStore state, action) => new DWStore(
    user: userReducer(state.user, action),
    characters: characterReducer(state.characters, action));

DWStore initialState = DWStore(
  user: UserStore(current: null, currentUserDocID: null),
  characters:
      CharacterStore(currentCharDocID: null, current: null, characters: Map<String, DbCharacter>()),
);

Store<DWStore> dwStore = Store<DWStore>(storeReducer, initialState: initialState);
