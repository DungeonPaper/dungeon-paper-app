import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/prefs_store.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

void withPrefs(Function(SharedPreferences inst) fn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  fn(prefs);
}

void sharedPrefsMiddleware(Store store, action, NextDispatcher next) {
  if (action is AppInit) {
    PrefsStore.loadAll();
  }

  if (action is SetPrefs) {
    withPrefs((prefs) {
      prefs.setString(
          keyMap[SharedPrefKeys.IdToken], action.prefs.credentials.idToken);
      prefs.setString(keyMap[SharedPrefKeys.AccessToken],
          action.prefs.credentials.accessToken);
      prefs.setString(keyMap[SharedPrefKeys.UserEmail], action.prefs.user.id);
      prefs.setString(keyMap[SharedPrefKeys.UserId], action.prefs.user.email);
      prefs.setString(keyMap[SharedPrefKeys.CharacterId],
          action.prefs.user.lastCharacterId);
    });
  }

  if (action is Credentials) {
    withPrefs((prefs) {
      prefs.setString(keyMap[SharedPrefKeys.IdToken], action.idToken);
      prefs.setString(keyMap[SharedPrefKeys.AccessToken], action.accessToken);
    });
  }

  if (action is SetCurrentChar) {
    withPrefs((prefs) {
      prefs.setString(keyMap[SharedPrefKeys.CharacterId], action.id);
    });
  }

  if (action is RemoveAll) {
    withPrefs((prefs) {
      prefs.remove(keyMap[SharedPrefKeys.CharacterId]);
    });
  }

  if (action is Login) {
    withPrefs((prefs) {
      prefs.setString(keyMap[SharedPrefKeys.UserId], action.user.docID);
      prefs.setString(keyMap[SharedPrefKeys.UserEmail], action.user.email);
      prefs.setString(
          keyMap[SharedPrefKeys.IdToken], action.credentials.idToken);
      prefs.setString(
          keyMap[SharedPrefKeys.AccessToken], action.credentials.accessToken);
    });
  }

  if (action is Logout) {
    withPrefs((prefs) {
      prefs.remove(keyMap[SharedPrefKeys.AccessToken]);
      prefs.remove(keyMap[SharedPrefKeys.IdToken]);
      prefs.remove(keyMap[SharedPrefKeys.UserId]);
      prefs.remove(keyMap[SharedPrefKeys.UserEmail]);
      prefs.remove(keyMap[SharedPrefKeys.CharacterId]);
    });
  }

  next(action);
}
