import 'dart:math';
import 'package:dungeon_paper/src/atoms/version_number.dart';
import 'package:dungeon_paper/src/dialogs/single_field_edit_dialog.dart';
import 'package:dungeon_paper/src/flutter_utils/input_validators.dart';
import 'package:dungeon_paper/src/flutter_utils/loading_container.dart';
import 'package:dungeon_paper/src/pages/about_view/about_view.dart';
import 'package:dungeon_paper/src/pages/auth/login_view.dart';
import 'package:dungeon_paper/src/pages/whats_new_view/whats_new_view.dart';
import 'package:dungeon_paper/src/utils/auth/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  final bool loading;

  const WelcomeView({
    Key key,
    @required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
      loading: loading,
      child: Center(
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Theme.of(context).accentColor),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: SizedBox.fromSize(
                    size: Size.square(
                        min(MediaQuery.of(context).size.width - 32, 200)),
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                Text('Welcome to Dungeon Paper!',
                    style: TextStyle(fontSize: 24)),
                VersionNumber.text(prefix: 'Version'),
                SizedBox(height: 24),
                LoginView(),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text('Changelog'),
                        RaisedButton(
                          color: Theme.of(context).colorScheme.surface,
                          onPressed: _openWhatsNew(context),
                          child: Text('Changelog'),
                        ),
                      ],
                    ),
                    SizedBox(width: 12),
                    Column(
                      children: [
                        Text("Can't sign in?"),
                        RaisedButton(
                          color: Theme.of(context).colorScheme.surface,
                          onPressed: _openResetPasswordView(context),
                          child: Text('Reset Password'),
                        ),
                        RaisedButton(
                          color: Theme.of(context).colorScheme.surface,
                          onPressed: _openAboutView(context),
                          child: Text('Contact Us'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Function() _openAboutView(BuildContext context) {
    return () {
      Navigator.push(
        context,
        MaterialPageRoute<bool>(
          fullscreenDialog: true,
          builder: (context) => AboutView(),
        ),
      );
    };
  }

  void Function() _openResetPasswordView(BuildContext context) {
    return () {
      showDialog(
        context: context,
        builder: (context) => SingleTextFieldEditDialog(
          title: Text('Reset Password'),
          confirmText: Text('Send Password Reset'),
          fieldName: 'Email address',
          value: '',
          onCancel: () => Navigator.pop(context),
          confirmDisabled: (email) => !EmailValidator.validate(email),
          onSave: (email) async {
            await sendPasswordResetLink(email);
            Navigator.pop(context);
          },
        ),
      );
    };
  }

  void Function() _openWhatsNew(BuildContext context) {
    return () {
      showDialog(
        context: context,
        builder: (context) => WhatsNew.dialog(),
      );
    };
  }
}
