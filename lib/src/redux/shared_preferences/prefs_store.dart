import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
import 'package:dungeon_paper/src/utils/auth.dart';
import 'package:dungeon_paper/src/utils/credentials.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:redux/redux.dart';

part 'shared_prefs_middleware.dart';
part 'pref_actions.dart';

enum SharedPrefKeys {
  UserEmail,
  UserId,
  CharacterId,
  AccessToken,
  IdToken,
  LastOpenedVersion
}

Map<SharedPrefKeys, String> keyMap = {
  SharedPrefKeys.AccessToken: 'accessToken',
  SharedPrefKeys.IdToken: 'idToken',
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
  Credentials credentials;
  UserDetails user;
  final Map<SharedPrefKeys, String> _map;

  PrefsStore({
    Map<SharedPrefKeys, String> map,
    this.credentials,
    this.user,
  }) : _map = map ?? {} {
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
      SharedPrefKeys.IdToken: prefs.getString(keyMap[SharedPrefKeys.IdToken]),
      SharedPrefKeys.AccessToken:
          prefs.getString(keyMap[SharedPrefKeys.AccessToken]),
      SharedPrefKeys.UserId: prefs.getString(keyMap[SharedPrefKeys.UserId]),
      SharedPrefKeys.UserEmail:
          prefs.getString(keyMap[SharedPrefKeys.UserEmail]),
      SharedPrefKeys.CharacterId:
          prefs.getString(keyMap[SharedPrefKeys.CharacterId]),
    };
    var store = PrefsStore(
      credentials: GoogleCredentials.fromAuthCredential(
        GoogleAuthCredential(
          idToken: _map[SharedPrefKeys.IdToken],
          accessToken: _map[SharedPrefKeys.AccessToken],
        ),
      ),
      user: UserDetails(
        id: _map[SharedPrefKeys.UserId],
        email: _map[SharedPrefKeys.UserEmail],
        lastCharacterId: _map[SharedPrefKeys.CharacterId],
      ),
      map: _map,
    );

    dwStore.dispatch(SetPrefs(store));
    if (store.credentials.isNotEmpty) {
      try {
        var user = await signInFlow(
          store.credentials,
          silent: true,
          interactiveOnFailSilent: false,
        );
        if (user == null) {
          throw SignInError('no_silent_login');
        }
      } on SignInError {
        dwStore.dispatch(NoLogin());
        print('Silent login failed');
      } catch (e) {
        print('Silent login unexpected error:');
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

  return state;
}
