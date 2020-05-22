part of 'user_store.dart';

class Login {
  User user;
  FirebaseUser firebaseUser;
  Credentials credentials;

  Login({
    @required this.user,
    @required this.firebaseUser,
    @required this.credentials,
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
