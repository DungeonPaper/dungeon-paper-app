import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class Credentials {
  String accessToken;
  String idToken;
  Type provider;
  AuthCredential _providerCreds;

  Credentials({
    this.accessToken,
    this.idToken,
    AuthCredential providerCredentials,
    @required this.provider,
  }) : _providerCreds = providerCredentials;

  AuthCredential get providerCredentials {
    if (_providerCreds != null) {
      return _providerCreds;
    }
    switch (provider) {
      case GoogleAuthProvider:
        return _providerCreds = googleCredentials;
    }
    return null;
  }

  AuthCredential get googleCredentials => GoogleAuthProvider.getCredential(
        accessToken: accessToken,
        idToken: idToken,
      );

  bool get isEmpty =>
      accessToken == null ||
      accessToken == '' ||
      idToken == null ||
      idToken == '';

  bool get isNotEmpty => !isEmpty;
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
      : credentials = credentials ?? Credentials(provider: null),
        user = user ?? UserDetails();

  static Future<void> loadAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PrefsStore store = PrefsStore(
      credentials: Credentials(
        idToken: prefs.getString(keyMap[SharedPrefKeys.IdToken]),
        accessToken: prefs.getString(keyMap[SharedPrefKeys.AccessToken]),
        provider: GoogleAuthProvider,
      ),
      user: UserDetails(
        id: prefs.getString(keyMap[SharedPrefKeys.UserId]),
        email: prefs.getString(keyMap[SharedPrefKeys.UserEmail]),
        lastCharacterId: prefs.getString(keyMap[SharedPrefKeys.CharacterId]),
      ),
    );

    dwStore.dispatch(SetPrefs(store));
    if (store.credentials.isNotEmpty) {
      unawaited(signInFlow(store.credentials));
    }
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
      id: action.user.docID,
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
      credentials: Credentials(provider: null),
    );
  }

  return state;
}
