part of 'auth_flow.dart';

Future<UserLogin> signInWithEmailAndPassword({
  @required String email,
  @required String password,
}) async {
  dwStore.dispatch(RequestLogin());
  final res = await performEmailAuth(email, password);
  return signInWithFbUser(res?.user);
}

Future<UserLogin> createUserWithEmailAndPassword({
  @required String email,
  @required String password,
}) async {
  assert(email != null && password != null);
  dwStore.dispatch(RequestLogin());
  final res = await auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  return signInWithFbUser(res?.user);
}

Future<AuthResult> performEmailAuth(String email, String password) async {
  final res = await auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  return res;
}
