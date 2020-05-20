import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

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
  Type provider;
  AuthCredential _providerCreds;
  Map<String, String> _map;

  Credentials({
    Map<String, String> data,
    AuthCredential providerCredentials,
    Type provider,
  })  : _map = data,
        _providerCreds = providerCredentials,
        this.provider = provider ?? providerCredentials?.runtimeType;

  String get idToken => _map['idToken'];
  String get accessToken => _map['accessToken'];

  factory Credentials.fromAuthCredential(AuthCredential credential) {
    switch (credential.runtimeType) {
      case GoogleAuthCredential:
        GoogleAuthCredential cred = credential;
        return Credentials(
          providerCredentials: cred,
          data: {
            'idToken': cred.idToken,
            'accessToken': cred.accessToken,
          },
        );
      default:
        return Credentials(providerCredentials: credential);
    }
  }

  Future<Credentials> refresh({bool attemptSilent}) {
    switch (provider) {
      case GoogleAuthCredential:
        return signInWithGoogle(silent: attemptSilent);
    }
    return null;
  }

  AuthCredential get providerCredentials {
    if (_providerCreds != null) {
      return _providerCreds;
    }
    switch (provider) {
      case GoogleAuthCredential:
        return _providerCreds = googleCredentials;
    }
    return null;
  }

  AuthCredential get googleCredentials => GoogleAuthCredential(
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
      : credentials = credentials ?? Credentials(),
        user = user ?? UserDetails();

  static Future<void> loadAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PrefsStore store = PrefsStore(
      credentials: Credentials.fromAuthCredential(
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
      credentials: Credentials(),
    );
  }

  return state;
}
