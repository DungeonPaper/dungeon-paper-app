import 'package:dungeon_paper/redux/stores/prefs_store.dart';
import 'package:dungeon_paper/refactor/auth.dart';
import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_paper/refactor/user.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AppInit {}

class Login {
  User user;
  FirebaseUser firebaseUser;
  ExposedAuthCredential credentials;

  Login({
    @required this.user,
    @required this.firebaseUser,
    @required this.credentials,
  });
}

class Logout {}

class NoLogin {}

class RequestLogin {}

class UserActions {
  static Login login({
    User user,
    ExposedAuthCredential credentials,
    FirebaseUser firebaseUser,
  }) =>
      Login(
        user: user,
        credentials: credentials,
        firebaseUser: firebaseUser,
      );
  static Logout logout() => Logout();
  static NoLogin noLogin() => NoLogin();
  static RequestLogin requestLogin() => RequestLogin();
  static SetUser setUser(User user) => SetUser(user);
  static SetFirebaseUser setFirebaseUser(FirebaseUser user) =>
      SetFirebaseUser(user);
}

class SetCurrentChar {
  final String id;
  final Character character;
  SetCurrentChar(this.id, this.character);
}

class SetUser {
  final User user;

  SetUser(this.user);
}

class SetFirebaseUser {
  final FirebaseUser user;

  SetFirebaseUser(this.user);
}

class SetCharacters {
  final Map<String, Character> characters;
  SetCharacters(this.characters);
}

class RemoveAll {}

class CharacterActions {
  static SetCurrentChar setCurrentChar(String id, Character data) =>
      SetCurrentChar(id, data);

  static SetCharacters setCharacters(Map<String, Character> characters) =>
      SetCharacters(characters);

  static RemoveAll remove() => RemoveAll();
}

class SetPrefs {
  final PrefsStore prefs;

  SetPrefs(this.prefs);
}

class SetCustomClasses {
  final Map<String, PlayerClass> classes;

  SetCustomClasses(this.classes);
}

class GetCustomClasses {}

class CustomClassesActions {
  static SetCustomClasses setCustomClasses(Map<String, PlayerClass> classes) =>
      SetCustomClasses(classes);
}
