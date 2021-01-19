part of 'user_controller.dart';

class Login {
  User user;
  fb.User firebaseUser;

  Login({
    @required this.user,
    @required this.firebaseUser,
  });
}

class Logout {}

class NoLogin {}

class RequestLogin {}

class SetUser {
  final User user;

  SetUser(this.user);
}

class SetFirebaseUser {
  final fb.User user;

  SetFirebaseUser(this.user);
}
