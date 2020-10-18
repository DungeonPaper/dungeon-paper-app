import 'package:dungeon_paper/src/atoms/password_field.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/utils/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';

class EmailAuthResult {
  final EmailAuthCredential credential;
  final bool isSignUp;

  EmailAuthResult({
    @required this.credential,
    @required this.isSignUp,
  });
}

class EmailAuthResponse {
  final dynamic error;
  final StackTrace stack;

  const EmailAuthResponse([this.error, this.stack]);

  bool get success => error == null && stack == null;
}

enum EmailAuthViewMode {
  signUp,
  signIn,
}

class EmailAuthView extends StatefulWidget {
  final Future<EmailAuthResponse> Function(EmailAuthResult) onConfirm;
  final void Function() onClose;
  final EmailAuthViewMode mode;
  final bool canSwitchModes;

  const EmailAuthView({
    Key key,
    @required this.onConfirm,
    this.mode,
    this.onClose,
    this.canSwitchModes = true,
  }) : super(key: key);

  @override
  _EmailAuthViewState createState() => _EmailAuthViewState();
}

class _EmailAuthViewState extends State<EmailAuthView> {
  Map<String, TextEditingController> controllers;
  EmailAuthViewMode mode;
  bool rememberMe;
  String error;
  String savedEmail;
  bool loading;
  ValueNotifier<bool> passwordValid;

  bool get signUpMode => mode == EmailAuthViewMode.signUp;
  bool get signInMode => mode == EmailAuthViewMode.signIn;

  @override
  void initState() {
    super.initState();
    mode = widget.mode ?? EmailAuthViewMode.signIn;
    controllers = WidgetUtils.textEditingControllerMap(
      map: {
        'email': EditingControllerConfig(
          defaultValue: '',
          listener: () => setState(() {}),
        ),
        'password': EditingControllerConfig(
          defaultValue: '',
          listener: () => setState(() {}),
        )
      },
    );
    loading = false;
    error = null;
    rememberMe = false;
    passwordValid = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        widget.onClose?.call();
        return Future.value(true);
      },
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        title: Text(
          signUpMode ? 'Sign Up' : 'Sign In',
          textScaleFactor: 2.2,
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: AutofillGroup(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 32),
                      TextFormField(
                        controller: controllers['email'],
                        autofillHints: [AutofillHints.email],
                        decoration: InputDecoration(
                          labelText: 'Email address',
                          hintText: 'example@domain.com',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (email) =>
                            email.isNotEmpty && !EmailValidator.validate(email)
                                ? 'Please enter a valid email address'
                                : null,
                      ),
                      SizedBox(height: 16),
                      PasswordField(
                        controller: controllers['password'],
                        validNotifier: passwordValid,
                      ),
                      SizedBox(height: 20),
                      if (error != null) ...[
                        Text(error, style: TextStyle(color: Colors.red)),
                        SizedBox(height: 20),
                      ],
                      if (widget.canSwitchModes) ...[
                        Text(signUpMode
                            ? 'Already have an account?'
                            : 'Need to create an account?'),
                        SizedBox(width: 10),
                        RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).colorScheme.onSecondary,
                          child: Text(
                            signUpMode ? 'Sign In' : 'Sign Up',
                            textScaleFactor: 1.1,
                          ),
                          onPressed: () => setState(
                            () => mode = mode == EmailAuthViewMode.signIn
                                ? EmailAuthViewMode.signUp
                                : EmailAuthViewMode.signIn,
                          ),
                        ),
                      ],
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 50,
              width: 120,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: loading || !isValid ? null : _confirm,
                child: loading
                    ? Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                          value: null,
                        ),
                      )
                    : Text(
                        signUpMode ? 'Sign Up' : 'Sign In',
                        textScaleFactor: 1.5,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get password => controllers['password'].text;
  String get email => controllers['email'].text;
  bool get isValid =>
      email?.isNotEmpty == true &&
      validateEmail(email) &&
      passwordValid.value == true;

  bool validateEmail(String email) => EmailValidator.validate(email);

  EmailAuthCredential get credential => EmailAuthProvider.credential(
        email: email,
        password: password,
      );

  void _confirm() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final response = await widget.onConfirm?.call(
        EmailAuthResult(
          credential: credential,
          isSignUp: signUpMode,
        ),
      );
      setState(() {
        loading = false;
        if (!response.success) {
          error = 'A general error occured. Please try again.';
        }
      });
    } catch (e) {
      setState(() {
        loading = false;
        error = e.message;
      });
    }
  }

  String errMessage(dynamic e) {
    switch (e.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
      case 'account-exists-with-different-credential':
        return e.message +
            '\n\nIf you are already signed up using other providers, '
                'sign in and link an email and password to your account.';
      case 'ERROR_WRONG_PASSWORD':
      case 'wrong-password':
        return 'Wrong email/password combination.';
      case 'ERROR_USER_NOT_FOUND':
      case 'user-not-found':
        return 'No user found with this email.';
      case 'ERROR_USER_DISABLED':
      case 'user-disabled':
        return 'User disabled.';
      case 'ERROR_TOO_MANY_REQUESTS':
      case 'operation-too-many-requests':
        return 'Too many requests to log into this account.';
      case 'ERROR_OPERATION_NOT_ALLOWED':
      case 'operation-not-allowed':
        return 'Server error, please try again later.';
      case 'ERROR_INVALID_EMAIL':
      case 'invalid-email':
        return 'Email address is invalid.';
      default:
        return 'Login failed. Please try again.';
    }
  }
}
