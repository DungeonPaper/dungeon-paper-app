part of 'prefs_store.dart';

void withPrefs(Function(SharedPreferences inst) fn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  fn(prefs);
}

void sharedPrefsMiddleware(Store<DWStore> store, action, NextDispatcher next) {
  if (action is AppInit) {
    PrefsStore.loadAll();
  }

  if (action is SetPrefs) {
    withPrefs((prefs) {
      for (var el in action.prefs.credentials.serialize().entries) {
        prefs.setString(el.key, el.value);
      }
      prefs.setString(keyMap[SharedPrefKeys.UserEmail], action.prefs.user.id);
      prefs.setString(keyMap[SharedPrefKeys.UserId], action.prefs.user.email);
      prefs.setString(keyMap[SharedPrefKeys.CharacterId],
          action.prefs.user.lastCharacterId);
    });
  }

  if (action is Credentials) {
    withPrefs((prefs) {
      for (var el in action.serialize().entries) {
        prefs.setString(el.key, el.value);
      }
    });
  }

  if (action is SetCurrentChar) {
    withPrefs((prefs) {
      prefs.setString(
          keyMap[SharedPrefKeys.CharacterId], action.character.documentID);
    });
  }

  if (action is ClearCharacters) {
    withPrefs((prefs) {
      prefs.remove(keyMap[SharedPrefKeys.CharacterId]);
    });
  }

  if (action is Login) {
    withPrefs((prefs) {
      prefs.setString(keyMap[SharedPrefKeys.UserId], action.user.documentID);
      prefs.setString(keyMap[SharedPrefKeys.UserEmail], action.user.email);
      for (var el in action.credentials.serialize().entries) {
        prefs.setString(el.key, el.value);
      }
    });
  }

  if (action is Logout) {
    withPrefs((prefs) {
      prefs.remove(keyMap[SharedPrefKeys.IdToken]);
      prefs.remove(keyMap[SharedPrefKeys.AccessToken]);
      prefs.remove(keyMap[SharedPrefKeys.UserId]);
      prefs.remove(keyMap[SharedPrefKeys.UserEmail]);
      prefs.remove(keyMap[SharedPrefKeys.CharacterId]);
    });
  }

  next(action);
}
