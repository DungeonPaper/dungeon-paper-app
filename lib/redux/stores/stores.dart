import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores/characters_store.dart';
import 'package:dungeon_paper/redux/stores/loading_store.dart';
import 'package:dungeon_paper/redux/stores/prefs_store.dart';
import 'package:dungeon_paper/redux/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:dungeon_paper/redux/stores/shared_prefs_middleware.dart';

class DWStore {
  final UserStore user;
  final CharacterStore characters;
  final Map<LoadingKeys, bool> loading;
  final PrefsStore prefs;

  DWStore({
    @required this.user,
    @required this.characters,
    @required this.loading,
    @required this.prefs,
  });
}

DWStore storeReducer(DWStore state, action) => DWStore(
      user: userReducer(state.user, action),
      characters: characterReducer(state.characters, action),
      loading: loadingReducer(state.loading, action),
      prefs: prefsReducer(state.prefs, action),
    );

DWStore initialState = DWStore(
  prefs: PrefsStore(),
  loading: {LoadingKeys.Character: false, LoadingKeys.User: false},
  user: UserStore(current: null, currentUserDocID: null),
  characters: CharacterStore(
      currentCharDocID: null,
      current: null,
      characters: Map<String, DbCharacter>()),
);

Store<DWStore> dwStore = Store<DWStore>(
  storeReducer,
  initialState: initialState,
  middleware: [
    LoggingMiddleware.printer(),
    sharedPrefsMiddleware,
  ],
);
