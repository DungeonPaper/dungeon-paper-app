import 'package:dungeon_paper/src/pages/auth/email_auth_dialog.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
import 'package:dungeon_paper/src/utils/auth/auth_common.dart';
import 'package:dungeon_paper/src/utils/auth/auth_flow.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:flutter/material.dart';

import 'login_button.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginButton(
          label: 'Google sign in',
          color: Colors.white,
          icon: Icon(Icons.g_translate),
          onPressed: () => _signIn(
            context,
            () => signInWithGoogle(interactive: true),
          ),
        ),
        SizedBox(height: 5),
        LoginButton(
          label: 'Email sign in',
          color: Colors.orange[100],
          icon: Icon(Icons.email),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => EmailAuthDialog(
              onLoggedIn: (user) => _signIn(
                context,
                () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _signIn(BuildContext context, void Function() doLogin) async {
    try {
      await doLogin();
    } on SignInError catch (err, stack) {
      logger.e('Normal sign in error:', err, stack);
      dwStore.dispatch(NoLogin());
      Scaffold.of(context, nullOk: true).showSnackBar(
        SnackBar(
          content: Text('Login failed.'),
          duration: Duration(seconds: 6),
        ),
      );
    } catch (err, stack) {
      logger.e('Irregular sign in error:', err, stack);
      dwStore.dispatch(NoLogin());
      try {
        Scaffold.of(context, nullOk: true).showSnackBar(
          SnackBar(
            content: Text('Something went wrong... Please try again later.'),
            duration: Duration(seconds: 10),
          ),
        );
      } catch (e, stack) {
        logger.e('Error displaying SnackBar', e, stack);
      }
    }
  }
}
