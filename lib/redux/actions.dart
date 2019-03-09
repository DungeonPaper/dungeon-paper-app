import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/stores/prefs_store.dart';

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
  static Credentials giveCredentials(String id, String token) => Credentials(idToken: id, accessToken: token);
}

class SetCurrentChar {
  final String id;
  final DbCharacter character;
  SetCurrentChar(this.id, this.character);
}

class SetCharacters {
  final Map<String, DbCharacter> characters;
  SetCharacters(this.characters);
}

class RemoveAll {}

class CharacterActions {
  static SetCurrentChar setCurrentChar(String id, DbCharacter data) =>
      SetCurrentChar(id, data);

  static SetCharacters setCharacters(Map<String, DbCharacter> characters) =>
      SetCharacters(characters);

  static RemoveAll remove() => RemoveAll();
}

class SetPrefs {
  final PrefsStore prefs;

  SetPrefs(this.prefs);
}
