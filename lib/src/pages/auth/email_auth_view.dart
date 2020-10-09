import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/src/flutter_utils/input_validators.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/utils/auth/auth_common.dart';
import 'package:dungeon_paper/src/utils/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';

class EmailAuthView extends StatefulWidget {
  final void Function(fb.User, EmailAuthCredential) onLoggedIn;
  final bool signUpMode;
  final bool linkMode;

  const EmailAuthView({
    Key key,
    @required this.onLoggedIn,
    this.signUpMode,
    this.linkMode,
  }) : super(key: key);

  @override
  _EmailAuthViewState createState() => _EmailAuthViewState();
}

class _EmailAuthViewState extends State<EmailAuthView> {
  Map<String, TextEditingController> controllers;
  bool signUpMode;
  bool obscured;
  bool rememberMe;
  String error;
  String savedEmail;
  bool loading;

  @override
  void initState() {
    super.initState();
    signUpMode = widget.signUpMode ?? false;
    controllers = WidgetUtils.textEditingControllerMap(
      map: {
        'email': EditingControllerConfig(
          defaultValue: '',
          listener: () => setState(() {}),
        ),
        'password': EditingControllerConfig(
          defaultValue: '',
          listener: () => setState(() {}),
        ),
      },
    );
    loading = false;
    error = null;
    rememberMe = false;
    obscured = true;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        Text(
          signUpMode ? 'Sign Up' : 'Sign In',
          textScaleFactor: 2.5,
          textAlign: TextAlign.center,
        ),
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: AutofillGroup(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controllers['email'],
                  autofillHints: [AutofillHints.email],
                  decoration: InputDecoration(
                    labelText: 'Email address',
                    hintText: 'example@domain.com',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (email) =>
                      email.isNotEmpty && !EmailValidator.validate(email)
                          ? 'Please enter a valid email address'
                          : null,
                ),
                TextFormField(
                  controller: controllers['password'],
                  autofillHints: [AutofillHints.password],
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: obscured ? Colors.grey[600] : Colors.blue[300],
                      ),
                      tooltip: obscured
                          ? 'Tap to show password'
                          : 'Tap to hide password',
                      onPressed: () => setState(() => obscured = !obscured),
                    ),
                  ),
                  obscureText: obscured,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: signUpMode
                      ? (pwd) => pwd.isNotEmpty && !validatePassword(password)
                          ? PasswordValidator.getMessage(password)
                          : null
                      : null,
                ),
                SizedBox(height: 20),
                if (error != null) ...[
                  Text(error, style: TextStyle(color: Colors.red)),
                  SizedBox(height: 20),
                ],
                Text(signUpMode
                    ? 'Already have an account?'
                    : 'Need to create an account?'),
                SizedBox(width: 10),
                RaisedButton(
                  visualDensity: VisualDensity.comfortable,
                  color: Theme.of(context).accentColor,
                  child: Text(
                    signUpMode ? 'Sign In' : 'Sign Up',
                    textScaleFactor: 1.1,
                  ),
                  onPressed: () => setState(() => signUpMode = !signUpMode),
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 50,
                    width: 120,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: loading || !isValid
                          ? null
                          : widget.linkMode == true
                              ? _link
                              : signUpMode
                                  ? _signUp
                                  : _login,
                      child: loading
                          ? Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
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
          ),
        ),
      ],
    );
  }

  String get password => controllers['password'].text;
  String get email => controllers['email'].text;
  bool get isValid =>
      email?.isNotEmpty == true &&
      validateEmail(email) &&
      (password?.isNotEmpty == true &&
          (!signUpMode || validatePassword(password)));

  bool validateEmail(String email) => EmailValidator.validate(email);
  bool validatePassword(String password) =>
      PasswordValidator.validate(password);

  void _link() async {
    try {
      var res = await linkWithCredentials(
        EmailAuthProvider.credential(
          email: email,
          password: password,
        ),
      );
      if (res) {
        widget.onLoggedIn?.call(auth.currentUser, credential);
      }
    } catch (e) {
      setState(() {
        loading = false;
        error = errMessage(e);
      });
    }
  }

  void _login() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      var res = await signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      widget.onLoggedIn?.call(res?.firebaseUser, credential);
    } catch (e) {
      setState(() {
        loading = false;
        error = errMessage(e);
      });
    }
  }

  void _signUp() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      var res = await createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      widget.onLoggedIn?.call(res?.firebaseUser, credential);
    } catch (e) {
      setState(() {
        loading = false;
        error = errMessage(e);
      });
    }
  }

  EmailAuthCredential get credential => EmailAuthProvider.credential(
        email: email,
        password: password,
      );

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
