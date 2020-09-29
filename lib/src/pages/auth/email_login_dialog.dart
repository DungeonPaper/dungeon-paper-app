import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:dungeon_paper/src/flutter_utils/input_validators.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/utils/auth/credentials/auth_credentials.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

class EmailLoginDialog extends StatefulWidget {
  final void Function(EmailCredentials) onLoggedIn;

  const EmailLoginDialog({
    Key key,
    @required this.onLoggedIn,
  }) : super(key: key);

  @override
  _EmailLoginDialogState createState() => _EmailLoginDialogState();
}

class _EmailLoginDialogState extends State<EmailLoginDialog> {
  Map<String, TextEditingController> controllers;
  bool obscured;
  bool rememberMe;

  @override
  void initState() {
    super.initState();
    controllers = WidgetUtils.textEditingControllerMap(
      map: {
        'email': EditingControllerConfig(
            defaultValue: '', listener: () => setState(() {})),
        'password': EditingControllerConfig(
            defaultValue: '', listener: () => setState(() {})),
      },
    );
    rememberMe = false;
    obscured = true;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        Text(
          'Sign In',
          textScaleFactor: 2.5,
          textAlign: TextAlign.center,
        ),
        AutofillGroup(
          child: Form(
            autovalidate: true,
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
                          ? 'Not a valid email'
                          : null,
                ),
                TextFormField(
                  controller: controllers['password'],
                  autofillHints: [AutofillHints.password],
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                          // obscured ? Icons.remove_red_eye : Icons.remove,
                          Icons.remove_red_eye,
                          color:
                              obscured ? Colors.grey[600] : Colors.blue[300]),
                      onPressed: () => setState(() => obscured = !obscured),
                    ),
                  ),
                  obscureText: obscured,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: (pwd) => pwd.isNotEmpty && pwd.length < 8
                      ? 'Password is too short'
                      : null,
                ),
                StandardDialogControls(
                  padding: EdgeInsets.only(top: 40),
                  okText: Text('Login'),
                  okDisabled: (email.isEmpty || !validateEmail(email)) ||
                      (password.isEmpty || !validatePassword(password)),
                  onOK: () => widget.onLoggedIn?.call(credentials),
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

  Credentials<EmailAuthCredential> get credentials =>
      EmailCredentials.fromAuthCredential(
        EmailAuthCredential(
          email: email,
          password: password,
        ),
      );
}
