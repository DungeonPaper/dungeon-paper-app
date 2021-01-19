import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'characters/characters_controller.dart';
import 'custom_classes/custom_classes_store.dart';
import 'loading/loading_controller.dart';
import 'shared_preferences/prefs_store.dart';
import 'users/user_controller.dart';

class AppInit {}

class DWStore {
  final UserController user;
  final CharacterController characters;
  final CustomClassesController customClasses;
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
    LoadingKeys.character: false,
    LoadingKeys.user: false,
    LoadingKeys.customClasses: false,
  },
  user: UserController(),
  characters: CharacterController(),
  customClasses: CustomClassesController(),
);

Store<DWStore> dwStore = Store<DWStore>(
  storeReducer,
  initialState: initialState,
  middleware: [
    LoggingMiddleware.printer(),
    sharedPrefsMiddleware,
  ],
);
