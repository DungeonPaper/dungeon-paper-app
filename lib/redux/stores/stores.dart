import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/actions/character_actions.dart';
import 'package:dungeon_paper/redux/actions/user_actions.dart';
import 'package:dungeon_paper/redux/stores/characters_reducer.dart';
import 'package:dungeon_paper/redux/stores/loading_reducer.dart';
import 'package:dungeon_paper/redux/stores/user_reducer.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DWStore {
  final UserStore user;
  final CharacterStore characters;
  final Map<LoadingKeys, bool> loading;

  DWStore({
    @required this.user,
    @required this.characters,
    @required this.loading,
  });
}

DWStore storeReducer(DWStore state, action) => DWStore(
      user: userReducer(state.user, action),
      characters: characterReducer(state.characters, action),
      loading: loadingReducer(state.loading, action),
    );

DWStore initialState = DWStore(
  loading: {LoadingKeys.Character: false, LoadingKeys.User: false},
  user: UserStore(current: null, currentUserDocID: null),
  characters: CharacterStore(
      currentCharDocID: null,
      current: null,
      characters: Map<String, DbCharacter>()),
);

void sharedPrefsMiddleware(Store store, action, NextDispatcher next) async {
  if (action is SetCurrentChar) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('characterId', action.id);
  }

  if (action is RemoveAll) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('characterId');
  }

  if (action is Login) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', action.id);
    prefs.setString('userEmail', action.user.email);
  }

  if (action is Logout) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove('userEmail');
    prefs.remove('characterId');
  }

  next(action);
}

Store<DWStore> dwStore = Store<DWStore>(
  storeReducer,
  initialState: initialState,
  middleware: [
    LoggingMiddleware.printer(),
    sharedPrefsMiddleware,
  ],
);
