part of 'auth_credentials.dart';

class GoogleCredentials extends Credentials<GoogleAuthCredential> {
  GoogleCredentials({
    Map<String, String> data,
    GoogleAuthCredential providerCredentials,
  }) : super(
          data: data ?? {},
          providerCredentials: providerCredentials ??
              GoogleAuthCredential(
                idToken: null,
                accessToken: null,
              ),
        );

  String get idToken => data['idToken'];
  String get accessToken => data['accessToken'];

  GoogleSignIn _googleSignInInstance;

  factory GoogleCredentials.fromAuthCredential(
    GoogleAuthCredential credential,
  ) =>
      GoogleCredentials(
        providerCredentials: credential,
        data: {
          'idToken': credential.idToken,
          'accessToken': credential.accessToken,
        },
      );

  @override
  Future<Credentials<AuthCredential>> generateCredentials({
    @required bool interactive,
  }) async {
    try {
      if (isNotEmpty) {
        return GoogleCredentials.fromAuthCredential(
          GoogleAuthProvider.getCredential(
            idToken: data['idToken'],
            accessToken: data['accessToken'],
          ),
        );
      }

      var gInstance = await _googleSignIn;
      GoogleSignInAccount gSignInAccount;
      if (!interactive) {
        try {
          gSignInAccount = await gInstance.signInSilently();
        } catch (e) {
          logger.e(e);
        }
      }

      if (gSignInAccount == null && interactive) {
        try {
          gSignInAccount = await gInstance.signIn();
        } catch (e) {
          throw SignInError('google_sign_in_error');
        }
      }

      if (gSignInAccount == null) {
        throw SignInError('user_cancel');
      }

      var gAuth = await gSignInAccount.authentication;

      return GoogleCredentials.fromAuthCredential(
        GoogleAuthProvider.getCredential(
          idToken: gAuth.idToken,
          accessToken: gAuth.accessToken,
        ),
      );
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<GoogleSignIn> get _googleSignIn async {
    if (_googleSignInInstance == null) {
      var secrets = await loadSecrets();
      var inst = kIsWeb
          ? GoogleSignIn(clientId: secrets.GOOGLE_CLIENT_ID)
          : GoogleSignIn();
      _googleSignInInstance = inst;
    }
    return _googleSignInInstance;
  }

  @override
  bool get isEmpty => data['accessToken'] == null || data['idToken'] == null;
}
