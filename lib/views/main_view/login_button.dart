import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/auth.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final void Function() onUserChange;

  LoginButton({Key key, this.onUserChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector<DWStore>(
      builder: (context, state) {
        var user = state.user.current;
        if (user == null) {
          return Container(
            width: 220,
            height: 50,
            child: RaisedButton(
              child: Text('Login with Google', style: TextStyle(fontSize: 20)),
              color: Theme.of(context).accentColor,
              onPressed: _handleSignIn(context),
            ),
          );
        }
        return SizedBox(height: 0, width: 0);
      },
    );
  }

  Function() _handleSignIn(BuildContext context) {
    return () async {
      try {
        var user = await signInFlow(SignInMethod.Google);
        if (user == null) {
          throw ('user_canceled');
        }
        if (onUserChange != null) {
          onUserChange();
        }
      } catch (e) {
        // if (e != 'user_canceled') {
        //   throw (e);
        // }
        print('SIGN IN ERROR:');
        print(e);
        Scaffold.of(context, nullOk: true).showSnackBar(
          SnackBar(
            content: Text('Login failed.'),
            duration: Duration(seconds: 6),
          ),
        );
      }
    };
  }
}
