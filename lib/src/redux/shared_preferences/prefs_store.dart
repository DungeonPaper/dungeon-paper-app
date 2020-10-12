import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/shared_preferences/prefs_settings.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
import 'package:dungeon_paper/src/utils/auth/auth.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';

part 'shared_prefs_middleware.dart';
part 'pref_actions.dart';

enum SharedPrefKeys {
  UserEmail,
  UserId,
  CharacterId,
  LastOpenedVersion,
}

Map<SharedPrefKeys, String> sharedPrefsKeyMap = {
  SharedPrefKeys.CharacterId: 'characterId',
  SharedPrefKeys.UserId: 'userId',
  SharedPrefKeys.UserEmail: 'userEmail',
};

class UserDetails {
  String email;
  String id;
  String lastCharacterId;

  UserDetails({this.id, this.email, this.lastCharacterId});
}

class PrefsStore {
  UserDetails user;
  PrefsSettings settings;

  final Map<SharedPrefKeys, String> _map;

  PrefsStore({
    Map<SharedPrefKeys, String> map,
    this.user,
    this.settings,
  }) : _map = map ?? {} {
    settings ??= PrefsSettings();
    _writeValuesFromMap(_map);
  }

  void _writeValuesFromMap(Map<SharedPrefKeys, String> map) {
    _writeUserFromMap(map);
  }

  List<SharedPrefKeys> _intersectKeys(
          List<SharedPrefKeys> source, List<SharedPrefKeys> target) =>
      source.where((el) => target.contains(el)).toList();

  void _prefLoader({
    @required List<SharedPrefKeys> checkList,
    @required Map<SharedPrefKeys, String> map,
    @required void Function(Map<SharedPrefKeys, String>) onListFull,
  }) {
    var intersect = _intersectKeys(checkList, [...map.keys, ..._map.keys]);
    if (_allKeysContain(intersect, map)) {
      onListFull({..._map, ...map});
    }
  }

  bool _allKeysContain(List<SharedPrefKeys> checkKeys,
          Map<SharedPrefKeys, String> existingKeys) =>
      checkKeys.every((key) => existingKeys.containsKey(key));

  void _writeUserFromMap(Map<SharedPrefKeys, String> map) {
    _prefLoader(
      map: map,
      checkList: [
        SharedPrefKeys.UserId,
        SharedPrefKeys.UserEmail,
        SharedPrefKeys.CharacterId,
      ],
      onListFull: (all) {
        user = UserDetails(
          id: all[SharedPrefKeys.UserId],
          email: all[SharedPrefKeys.UserEmail],
          lastCharacterId: all[SharedPrefKeys.CharacterId],
        );
      },
    );
  }

  static Future<void> loadAll() async {
    var prefs = await SharedPreferences.getInstance();
    var _map = <SharedPrefKeys, String>{
      SharedPrefKeys.UserId:
          prefs.getString(sharedPrefsKeyMap[SharedPrefKeys.UserId]),
      SharedPrefKeys.UserEmail:
          prefs.getString(sharedPrefsKeyMap[SharedPrefKeys.UserEmail]),
      SharedPrefKeys.CharacterId:
          prefs.getString(sharedPrefsKeyMap[SharedPrefKeys.CharacterId]),
    };
    var store = PrefsStore(
      user: UserDetails(
        id: _map[SharedPrefKeys.UserId],
        email: _map[SharedPrefKeys.UserEmail],
        lastCharacterId: _map[SharedPrefKeys.CharacterId],
      ),
      map: _map,
      settings: PrefsSettings.loadFromPrefs(prefs)..applyAllSettings(),
    );

    dwStore.dispatch(SetPrefs(store));
    dwStore.dispatch(RequestLogin());
    try {
      var user = await signInAutomatically();
      if (user == null) {
        throw SignInError('no_silent_login');
      }
    } on SignInError {
      dwStore.dispatch(NoLogin());
      logger.d('Silent login failed');
    } catch (e) {
      dwStore.dispatch(NoLogin());
      logger.d('Silent login unexpected error:');
      rethrow;
    }
  }
}

PrefsStore prefsReducer(PrefsStore state, action) {
  if (action is SetPrefs) {
    state = action.prefs;
  }

  if (action is SetCurrentChar) {
    state.user.lastCharacterId = action.character.documentID;
  }

  if (action is ClearCharacters) {
    state.user.lastCharacterId = null;
  }

  if (action is Login) {
    state.user = UserDetails(
      id: action.user.documentID,
      email: action.user.email,
      lastCharacterId: state.user.lastCharacterId,
    );
  }

  if (action is Logout) {
    state = PrefsStore(
      user: UserDetails(),
    );
  }

  if (action is ChangeSetting) {
    state.settings.set(action.name, action.value);
    return state;
  }

  return state;
}
