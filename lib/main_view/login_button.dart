import 'package:dungeon_paper/db/auth.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final void Function() onUserChange;
  LoginButton({Key key, this.onUserChange}) : super(key: key);

  @override
  LoginButtonState createState() =>
      LoginButtonState(onUserChange: onUserChange);
}

class LoginButtonState extends State<LoginButton> {
  final void Function() onUserChange;
  LoginButtonState({this.onUserChange});

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector(
      builder: (context, state) {
        DbUser user = state.user.current;
        if (user == null) {
          return Container(
            width: 220,
            height: 50,
            child: RaisedButton(
              child: Text('Login with Google', style: TextStyle(fontSize: 20)),
              color: Theme.of(context).accentColor,
              onPressed: _handleSignIn,
            ),
          );
        }
        return SizedBox(height: 0, width: 0);
      },
    );
  }

  void _handleSignIn() async {
    try {
      var user = await requestSignInWithCredentials();
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
      Scaffold.of(context, nullOk: true).showSnackBar(
        SnackBar(
          content: Text('Login failed.'),
          duration: Duration(seconds: 6),
        ),
      );
    }
  }
}
