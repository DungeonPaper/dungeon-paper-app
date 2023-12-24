import 'package:dungeon_paper/app/data/services/auth_provider.dart';
import 'package:dungeon_paper/app/data/services/loading_provider.dart';
import 'package:dungeon_paper/core/utils/password_validator.dart';
import 'package:dungeon_paper/core/utils/secrets_base.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LoginController extends ChangeNotifier with AuthProviderMixin {
  final formKey = GlobalKey<FormState>(debugLabel: 'loginForm');
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();
  var _valid = false;
  var _signup = false;

  bool get valid => _valid;
  bool get isSignUp => _signup;
  bool get isLogin => !isSignUp;

  LoginController() {
    email.addListener(validate);
    password.addListener(validate);
    passwordConfirm.addListener(validate);
  }

  void toggleSignup() {
    _signup = !_signup;
    notifyListeners();
  }

  void _loginWrapper(BuildContext context, Future<void> Function() cb) async {
    final messenger = ScaffoldMessenger.of(context);
    final loadingProvider = LoadingProvider.of(context);
    try {
      final navigator = Navigator.of(context);
      loadingProvider.loadingUser = true;
      loadingProvider.loadingCharacters = false;
      await cb();
      navigator.popUntil((route) => route.isFirst);
    } catch (e) {
      if (secrets.sentryDsn.isNotEmpty) {
        Sentry.captureException(e);
      }
      debugPrint('ERROR: $e');
      loadingProvider.loadingUser = false;
      loadingProvider.loadingCharacters = false;
      // TODO intl
      messenger.showSnackBar(const SnackBar(content: Text('Login failed')));
    }
  }

  void loginWithPassword(
    BuildContext context,
  ) async {
    _loginWrapper(
      context,
      () => authProvider.loginWithPassword(
          email: email.text, password: password.text),
    );
  }

  void loginWithGoogle(
    BuildContext context,
  ) async {
    _loginWrapper(
      context,
      () => authProvider.loginWithGoogle(),
    );
  }

  void loginWithApple(
    BuildContext context,
  ) async {
    _loginWrapper(
      context,
      () => authProvider.loginWithApple(),
    );
  }

  void signUp(
    BuildContext context,
  ) {
    _loginWrapper(
      context,
      () => authProvider.signUp(email: email.text, password: password.text),
    );
  }

  void setValid(bool valid) {
    debugPrint('setValid: $valid');
    _valid = valid;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    passwordConfirm.dispose();
  }

  bool validate() {
    _valid = [
      email.text.isNotEmpty,
      EmailValidator.validate(email.text),
      password.text.isNotEmpty,
      PasswordValidator().validator(password.text) == null,
      if (isSignUp) ...[
        passwordConfirm.text.isNotEmpty,
        password.text == passwordConfirm.text,
      ],
    ].every((c) => c == true);
    notifyListeners();
    debugPrint('valid: $_valid');
    return _valid;
  }
}

