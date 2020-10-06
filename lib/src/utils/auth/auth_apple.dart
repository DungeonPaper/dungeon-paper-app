part of 'auth_flow.dart';

Future<bool> checkAppleSignIn() async {
  return AppleSignIn.isAvailable();
}

Future<UserLogin> signInWithApple({
  @required bool interactive,
}) async {
  dwStore.dispatch(RequestLogin());
  final credential = await getAppleCredential(interactive: interactive);
  return signInWithCredentials(credential);
}

Future<OAuthCredential> getAppleCredential({
  @required bool interactive,
}) async {
  final result = await AppleSignIn.performRequests([
    AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
  ]);
  final appleIdCredential = result.credential;
  final oAuthProvider = OAuthProvider(providerId: 'apple.com');
  final credential = oAuthProvider.getCredential(
    idToken: String.fromCharCodes(appleIdCredential.identityToken),
    accessToken: String.fromCharCodes(appleIdCredential.authorizationCode),
  );
  return credential;
}
