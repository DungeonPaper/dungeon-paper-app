import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
import 'package:dungeon_paper/src/utils/auth.dart';
import 'package:dungeon_paper/src/utils/credentials.dart';
import 'package:pedantic/pedantic.dart';
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

  PrefsStore({this.credentials, this.user});

  static Future<void> loadAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PrefsStore store = PrefsStore(
      credentials: GoogleCredentials.fromAuthCredential(
        GoogleAuthCredential(
          idToken: prefs.getString(keyMap[SharedPrefKeys.IdToken]),
          accessToken: prefs.getString(keyMap[SharedPrefKeys.AccessToken]),
        ),
      ),
      user: UserDetails(
        id: prefs.getString(keyMap[SharedPrefKeys.UserId]),
        email: prefs.getString(keyMap[SharedPrefKeys.UserEmail]),
        lastCharacterId: prefs.getString(keyMap[SharedPrefKeys.CharacterId]),
      ),
    );

    dwStore.dispatch(SetPrefs(store));
    if (store.credentials.isNotEmpty) {
      try {
        unawaited(signInFlow(
          store.credentials,
          silent: true,
          interactiveOnFailSilent: false,
        ));
      } on Exception {
        print('Silent login failed');
      }
    }
  }
}

PrefsStore prefsReducer(PrefsStore state, action) {
  if (action is SetPrefs) {
    state = action.prefs;
  }

  if (action is SetCurrentChar) {
    state.user.lastCharacterId = action.character.docID;
  }

  if (action is ClearCharacters) {
    state.user.lastCharacterId = null;
  }

  if (action is Login) {
    state.user = UserDetails(
      id: action.user.docID,
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
