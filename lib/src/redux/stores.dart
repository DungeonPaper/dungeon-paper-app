import 'package:dungeon_paper/db/models/character.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'characters/characters_store.dart';
import 'custom_classes/custom_classes_store.dart';
import 'loading/loading_store.dart';
import 'shared_preferences/prefs_store.dart';
import 'users/user_store.dart';

class AppInit {}

class DWStore {
  final UserStore user;
  final CharacterStore characters;
  final CustomClassesStore customClasses;
  final Map<LoadingKeys, bool> loading;
  final PrefsStore prefs;

  DWStore({
    @required this.user,
    @required this.characters,
    @required this.loading,
    @required this.prefs,
    @required this.customClasses,
  });
}

DWStore storeReducer(DWStore state, action) => DWStore(
      user: userReducer(state.user, action),
      characters: characterReducer(state.characters, action),
      loading: loadingReducer(state.loading, action),
      prefs: prefsReducer(state.prefs, action),
      customClasses: customClassesReducer(state.customClasses, action),
    );

var initialState = DWStore(
  prefs: PrefsStore(),
  loading: {
    LoadingKeys.Character: false,
    LoadingKeys.User: false,
    LoadingKeys.CustomClasses: false,
  },
  user: UserStore(current: null, currentUserDocID: null, firebaseUser: null),
  characters: CharacterStore(
    current: null,
    characters: <String, Character>{},
  ),
  customClasses: CustomClassesStore(
    customClasses: {},
  ),
);

Store<DWStore> dwStore = Store<DWStore>(
  storeReducer,
  initialState: initialState,
  middleware: [
    LoggingMiddleware.printer(),
    sharedPrefsMiddleware,
  ],
);
