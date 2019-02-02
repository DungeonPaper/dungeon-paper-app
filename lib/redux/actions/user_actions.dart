import 'package:dungeon_paper/db/user.dart';

class Login {
  String id;
  DbUser user;
  Login(this.id, this.user);
}

class Logout {}
class NoLogin {}
class RequestLogin {}


class UserActions {
  static Login login(String id, DbUser user) =>
      Login(id, user);

  static Logout logout() => Logout();
  static NoLogin noLogin() => NoLogin();
  static RequestLogin requestLogin() => RequestLogin();
}
