part of 'auth_credentials.dart';

class EmailCredentials extends Credentials<EmailAuthCredential> {
  EmailCredentials({
    Map<String, String> data,
    EmailAuthCredential providerCredentials,
  }) : super(
          data: data ?? {},
          providerCredentials: providerCredentials,
        );

  String get email => data['email'];
  String get password => data['password'];

  factory EmailCredentials.fromAuthCredential(
    EmailAuthCredential credential,
  ) =>
      EmailCredentials(
        providerCredentials: credential,
        data: {
          'email': credential.email,
          'password': credential.password,
        },
      );

  @override
  Future<Credentials<AuthCredential>> generateCredentials({
    @required bool interactive,
  }) async {
    try {
      if (isEmpty) {
        throw SignInError('credentials_empty');
      }

      return EmailCredentials.fromAuthCredential(
        EmailAuthProvider.getCredential(
          email: email,
          password: password,
        ),
      );
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<UserLogin> signUp() async {
    var res = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return signInWithFbUser(res.user, this);
  }

  @override
  bool get isEmpty =>
      data['email']?.isNotEmpty != true && data['password']?.isNotEmpty != true;

  @override
  Map<String, String> serialize() => {...data}..remove('password');
}
