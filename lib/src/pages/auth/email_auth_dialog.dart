import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:dungeon_paper/src/flutter_utils/input_validators.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/utils/auth/auth_flow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class EmailAuthDialog extends StatefulWidget {
  final void Function(FirebaseUser) onLoggedIn;
  final bool signUpMode;

  const EmailAuthDialog({
    Key key,
    @required this.onLoggedIn,
    this.signUpMode,
  }) : super(key: key);

  @override
  _EmailAuthDialogState createState() => _EmailAuthDialogState();
}

class _EmailAuthDialogState extends State<EmailAuthDialog> {
  Map<String, TextEditingController> controllers;
  bool signUpMode;
  bool obscured;
  bool rememberMe;
  String error;

  @override
  void initState() {
    super.initState();
    signUpMode = widget.signUpMode ?? false;
    controllers = WidgetUtils.textEditingControllerMap(
      map: {
        'email': EditingControllerConfig(
            defaultValue: '', listener: () => setState(() {})),
        'password': EditingControllerConfig(
            defaultValue: '', listener: () => setState(() {})),
      },
    );
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
          autovalidate: true,
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
                Row(
                  children: [
                    Text(signUpMode
                        ? 'Already have an account?'
                        : 'Need to create an account?'),
                    SizedBox(width: 10),
                    RaisedButton(
                      visualDensity: VisualDensity.compact,
                      color: Theme.of(context).primaryColor,
                      child: Text(signUpMode ? 'Sign In' : 'Sign Up'),
                      onPressed: () => setState(() => signUpMode = !signUpMode),
                    ),
                  ],
                ),
                StandardDialogControls(
                  padding: EdgeInsets.only(top: 40),
                  okText: Text(signUpMode ? 'Sign Up' : 'Sign In'),
                  okDisabled: (email.isEmpty || !validateEmail(email)) ||
                      (password.isEmpty ||
                          signUpMode && !validatePassword(password)),
                  onOK: signUpMode ? signUp : login,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  String get password => controllers['password'].text;
  String get email => controllers['email'].text;

  bool validateEmail(String email) => EmailValidator.validate(email);
  bool validatePassword(String password) =>
      PasswordValidator.validate(password);

  void login() async {
    var res = await signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    widget.onLoggedIn?.call(res.firebaseUser);
  }

  void signUp() async {
    try {
      var res = await createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      widget.onLoggedIn?.call(res.firebaseUser);
    } catch (e) {
      setState(() {
        error = e.message;
        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          error += '\nIf you are already signed up using other providers, '
              'sign in and link an email and password to your account.';
        }
      });
    }
  }
}
