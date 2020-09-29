part of 'prefs_store.dart';

void withPrefs(Function(SharedPreferences inst) fn) async {
  var prefs = await SharedPreferences.getInstance();
  fn(prefs);
}

void sharedPrefsMiddleware(Store<DWStore> store, action, NextDispatcher next) {
  if (action is AppInit) {
    PrefsStore.loadAll();
  }

  if (action is SetPrefs) {
    withPrefs((prefs) {
      prefs.setString(
          sharedPrefsKeyMap[SharedPrefKeys.UserEmail], action.prefs.user.id);
      prefs.setString(
          sharedPrefsKeyMap[SharedPrefKeys.UserId], action.prefs.user.email);
      prefs.setString(
        sharedPrefsKeyMap[SharedPrefKeys.CharacterId],
        action.prefs.user.lastCharacterId,
      );
    });
  }

  if (action is SetCurrentChar) {
    withPrefs((prefs) {
      prefs.setString(sharedPrefsKeyMap[SharedPrefKeys.CharacterId],
          action.character.documentID);
    });
  }

  if (action is ClearCharacters) {
    withPrefs((prefs) {
      prefs.remove(sharedPrefsKeyMap[SharedPrefKeys.CharacterId]);
    });
  }

  if (action is Login) {
    withPrefs((prefs) {
      prefs.setString(
          sharedPrefsKeyMap[SharedPrefKeys.UserId], action.user.documentID);
      prefs.setString(
          sharedPrefsKeyMap[SharedPrefKeys.UserEmail], action.user.email);
    });
  }

  if (action is Logout) {
    withPrefs((prefs) {
      prefs.remove(sharedPrefsKeyMap[SharedPrefKeys.UserId]);
      prefs.remove(sharedPrefsKeyMap[SharedPrefKeys.UserEmail]);
      prefs.remove(sharedPrefsKeyMap[SharedPrefKeys.CharacterId]);
    });
  }

  if (action is ChangeSetting) {
    withPrefs((prefs) {
      PrefsSettings.setToPrefs(prefs, action.name, action.value);
    });
  }

  next(action);
}
