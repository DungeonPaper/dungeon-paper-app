import 'package:dungeon_paper/db/auth.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedPrefKeys {
  UserEmail,
  UserId,
  CharacterId,
  AccessToken,
  IdToken,
}

Map<SharedPrefKeys, String> keyMap = {
  SharedPrefKeys.AccessToken: 'accessToken',
  SharedPrefKeys.IdToken: 'idToken',
  SharedPrefKeys.CharacterId: 'characterId',
  SharedPrefKeys.UserId: 'userId',
  SharedPrefKeys.UserEmail: 'userEmail',
};

class Credentials {
  String accessToken;
  String idToken;

  Credentials({this.accessToken, this.idToken});
}

class UserDetails {
  String email;
  String id;
  String lastCharacterId;

  UserDetails({this.id, this.email, this.lastCharacterId});
}

class PrefsStore {
  Credentials credentials;
  UserDetails user;

  PrefsStore({Credentials credentials, UserDetails user})
      : credentials = credentials ?? Credentials(),
        user = user ?? UserDetails();

  static Future<PrefsStore> loadAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PrefsStore store = PrefsStore(
      credentials: Credentials(
        idToken: prefs.getString(keyMap[SharedPrefKeys.IdToken]),
        accessToken: prefs.getString(keyMap[SharedPrefKeys.AccessToken]),
      ),
      user: UserDetails(
        id: prefs.getString(keyMap[SharedPrefKeys.UserId]),
        email: prefs.getString(keyMap[SharedPrefKeys.UserEmail]),
        lastCharacterId: prefs.getString(keyMap[SharedPrefKeys.CharacterId]),
      ),
    );

    dwStore.dispatch(SetPrefs(store));
    performSignIn();
    return store;
  }
}

PrefsStore prefsReducer(PrefsStore state, action) {
  if (action is SetPrefs) {
    state = action.prefs;
  }

  if (action is SetCurrentChar) {
    state.user.lastCharacterId = action.id;
  }

  if (action is RemoveAll) {
    state.user.lastCharacterId = null;
  }

  if (action is Login) {
    state.user = UserDetails(
      id: action.id,
      email: action.user.email,
      lastCharacterId: state.user.lastCharacterId,
    );
  }

  if (action is Credentials) {
    state.credentials = action;
  }

  if (action is Logout) {
    state = PrefsStore(
      user: UserDetails(),
      credentials: Credentials(),
    );
  }

  return state;
}
