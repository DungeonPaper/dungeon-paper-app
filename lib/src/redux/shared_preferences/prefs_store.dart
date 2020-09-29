import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/shared_preferences/prefs_settings.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
import 'package:dungeon_paper/src/utils/auth/auth_common.dart';
import 'package:dungeon_paper/src/utils/auth/auth_flow.dart';
import 'package:dungeon_paper/src/utils/auth/credentials/auth_credentials.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:redux/redux.dart';
import 'package:dungeon_paper/src/utils/class_extensions/map_extensions.dart';

part 'shared_prefs_middleware.dart';
part 'pref_actions.dart';

enum SharedPrefKeys {
  UserEmail,
  UserId,
  CharacterId,
  LastOpenedVersion,
  SignInProvider,
  IdToken,
  AccessToken,
}

Map<SharedPrefKeys, String> keyMap = {
  SharedPrefKeys.AccessToken: 'accessToken',
  SharedPrefKeys.IdToken: 'idToken',
  SharedPrefKeys.CharacterId: 'characterId',
  SharedPrefKeys.UserId: 'userId',
  SharedPrefKeys.UserEmail: 'userEmail',
  SharedPrefKeys.SignInProvider: 'signInProvider',
};

class UserDetails {
  String email;
  String id;
  String lastCharacterId;

  UserDetails({this.id, this.email, this.lastCharacterId});
}

class PrefsStore {
  Credentials credentials;
  UserDetails user;
  PrefsSettings settings;

  final Map<SharedPrefKeys, String> _map;

  PrefsStore({
    Map<SharedPrefKeys, String> map,
    this.credentials,
    this.user,
    this.settings,
  }) : _map = map ?? {} {
    settings ??= PrefsSettings();
    _writeValuesFromMap(_map);
  }

  void _writeValuesFromMap(Map<SharedPrefKeys, String> map) {
    _writeGoogleCredsFromMap(map);
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

  void _writeGoogleCredsFromMap(Map<SharedPrefKeys, String> map) {
    _prefLoader(
      map: map,
      checkList: [
        SharedPrefKeys.IdToken,
        SharedPrefKeys.AccessToken,
      ],
      onListFull: (all) {
        credentials = GoogleCredentials.fromAuthCredential(
          GoogleAuthCredential(
            idToken: all[SharedPrefKeys.IdToken],
            accessToken: all[SharedPrefKeys.AccessToken],
          ),
        );
      },
    );
  }

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
      SharedPrefKeys.SignInProvider:
          prefs.getString(keyMap[SharedPrefKeys.SignInProvider]),
      SharedPrefKeys.IdToken: prefs.getString(keyMap[SharedPrefKeys.IdToken]),
      SharedPrefKeys.AccessToken:
          prefs.getString(keyMap[SharedPrefKeys.AccessToken]),
      SharedPrefKeys.UserId: prefs.getString(keyMap[SharedPrefKeys.UserId]),
      SharedPrefKeys.UserEmail:
          prefs.getString(keyMap[SharedPrefKeys.UserEmail]),
      SharedPrefKeys.CharacterId:
          prefs.getString(keyMap[SharedPrefKeys.CharacterId]),
    };
    if (_map[SharedPrefKeys.AccessToken] != null &&
        _map[SharedPrefKeys.IdToken] != null &&
        _map[SharedPrefKeys.SignInProvider] == null) {
      _map[SharedPrefKeys.SignInProvider] =
          signInMethodKeys.inverse[SignInMethod.Google];
      await prefs.setString(
        keyMap[SharedPrefKeys.SignInProvider],
        signInMethodKeys.inverse[SignInMethod.Google],
      );
    }
    var store = PrefsStore(
      credentials: Credentials.fromStorage(
        _map[SharedPrefKeys.SignInProvider],
        _map.map((k, v) => MapEntry(keyMap[k], v)),
      ),
      user: UserDetails(
        id: _map[SharedPrefKeys.UserId],
        email: _map[SharedPrefKeys.UserEmail],
        lastCharacterId: _map[SharedPrefKeys.CharacterId],
      ),
      map: _map,
      settings: PrefsSettings.loadFromPrefs(prefs)..applyAllSettings(),
    );

    dwStore.dispatch(SetPrefs(store));
    if (store.credentials.isNotEmpty) {
      try {
        var user =
            await signInWithCredentials(store.credentials, interactive: false);
        if (user == null) {
          throw SignInError('no_silent_login');
        }
      } on SignInError {
        dwStore.dispatch(NoLogin());
        logger.d('Silent login failed');
      } catch (e) {
        logger.d('Silent login unexpected error:');
        rethrow;
      }
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
    state.credentials = action.credentials;
  }

  if (action is Logout) {
    state = PrefsStore(
      user: UserDetails(),
      credentials: null,
    );
  }

  if (action is ChangeSetting) {
    state.settings.set(action.name, action.value);
    return state;
  }

  return state;
}
