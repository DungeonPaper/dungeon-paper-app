import 'package:dungeon_paper/db/user.dart';

class Login {
  String id;
  DbUser user;
  Login(this.id, this.user);
}

class Logout {}

class UserActions {
  static Login login(String id, DbUser user) =>
      Login(id, user);

  static Logout logout() => Logout();
}
