import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:dungeon_paper/src/pages/auth/email_auth_view.dart';
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
          icon: Image(
            image: AssetImage('assets/social/google.png'),
            width: 30,
            height: 30,
          ),
          onPressed: () => _signIn(
            context,
            () => signInWithGoogle(interactive: true),
          ),
        ),
        SizedBox(height: 5),
        FutureBuilder(
          future: checkAppleSignIn(),
          builder: (context, AsyncSnapshot<bool> available) => available.data == true
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: LoginButton(
                    label: 'Apple sign in',
                    color: Colors.black,
                    textColor: Colors.white,
                    icon: PlatformSvg.asset(
                      'social/apple.svg',
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () => _signIn(
                      context,
                      () => signInWithApple(interactive: true),
                    ),
                  ),
                )
              : Container(),
        ),
        // LoginButton(
        //   label: 'Facebook sign in',
        //   color: Color(0xFF1878F3),
        //   textColor: Colors.white,
        //   icon: PlatformSvg.asset(
        //     'social/facebook.svg',
        //     size: 20,
        //     color: Colors.white,
        //   ),
        //   onPressed: () => _signIn(
        //     context,
        //     () => signInWithGoogle(interactive: true),
        //   ),
        // ),
        // SizedBox(height: 5),
        LoginButton(
          label: 'Email sign in',
          textColor: Theme.of(context).colorScheme.onSecondary,
          icon: Icon(
            Icons.email,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => EmailAuthView(
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
