import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/redux/connectors.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  // final void Function(UserLogin login) onUserChange;
  final void Function() onPressed;
  final String label;
  final Color color;
  final Widget icon;

  LoginButton({
    Key key,
    @required this.onPressed,
    @required this.label,
    @required this.color,
    @required this.icon,
    // this.onUserChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector<User>(
      converter: (store) => store.state.user.current,
      builder: (context, user) {
        if (user == null) {
          return Container(
            width: 220,
            height: 40,
            child: RaisedButton.icon(
              icon: icon,
              label: Container(
                width: 120,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              color: color ?? Theme.of(context).accentColor,
              onPressed: onPressed,
            ),
          );
        }
        return SizedBox(height: 0, width: 0);
      },
    );
  }
}
