import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/stores/prefs_store.dart';
import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_world_data/player_class.dart';

class AppInit {}

class Login {
  String id;
  DbUser user;
  Login(this.id, this.user);
}

class Logout {}

class NoLogin {}

class RequestLogin {}

class UserActions {
  static Login login(String id, DbUser user) => Login(id, user);
  static Logout logout() => Logout();
  static NoLogin noLogin() => NoLogin();
  static RequestLogin requestLogin() => RequestLogin();
  static Credentials giveCredentials(String idToken, String accessToken) =>
      Credentials(idToken: idToken, accessToken: accessToken);
}

class SetCurrentChar {
  final String id;
  final Character character;
  SetCurrentChar(this.id, this.character);
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
