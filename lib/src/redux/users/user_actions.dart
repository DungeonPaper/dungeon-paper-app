part of 'user_store.dart';

class Login {
  User user;
  FirebaseUser firebaseUser;

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
  final FirebaseUser user;

  SetFirebaseUser(this.user);
}
