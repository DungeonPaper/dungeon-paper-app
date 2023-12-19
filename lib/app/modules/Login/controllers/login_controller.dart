import 'package:dungeon_paper/app/data/services/auth_service.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/core/utils/secrets_base.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LoginController extends ChangeNotifier
    with AuthServiceMixin, LoadingServiceMixin, CharacterServiceMixin {
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

  void toggleSignup() => _signup = !_signup;

  void _loginWrapper(BuildContext context, Future<void> Function() cb) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final navigator = Navigator.of(context);
      loadingService.loadingUser = true;
      loadingService.loadingCharacters = false;
      await cb();
      navigator.popUntil((route) => route.isFirst);
    } catch (e) {
      if (secrets.sentryDsn.isNotEmpty) {
        Sentry.captureException(e);
      }
      debugPrint('ERROR: $e');
      loadingService.loadingUser = false;
      loadingService.loadingCharacters = false;
      // TODO intl
      messenger.showSnackBar(const SnackBar(content: Text('Login failed')));
    }
  }

  void loginWithPassword(
    BuildContext context,
  ) async {
    _loginWrapper(
      context,
      () => authService.loginWithPassword(
          email: email.text, password: password.text),
    );
  }

  void loginWithGoogle(
    BuildContext context,
  ) async {
    _loginWrapper(
      context,
      () => authService.loginWithGoogle(),
    );
  }

  void loginWithApple(
    BuildContext context,
  ) async {
    _loginWrapper(
      context,
      () => authService.loginWithApple(),
    );
  }

  void signUp(
    BuildContext context,
  ) {
    _loginWrapper(
      context,
      () => authService.signUp(email: email.text, password: password.text),
    );
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    passwordConfirm.dispose();
  }

  bool validate() {
    return _valid = formKey.currentState?.validate() ?? false;
  }
}

