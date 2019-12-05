import 'dart:math';
import 'package:dungeon_paper/db/auth.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:flutter/material.dart';

class UserBadge extends StatefulWidget {
  final void Function() onUserChange;
  UserBadge({Key key, this.onUserChange}) : super(key: key);

  @override
  UserBadgeState createState() => UserBadgeState(onUserChange: onUserChange);
}

class UserBadgeState extends State<UserBadge> {
  final void Function() onUserChange;
  UserBadgeState({this.onUserChange});

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector(
      builder: (context, state) {
        DbUser user = state.user.current;
        if (user == null) {
          return IconButton(
            icon: CircleAvatar(
              child: Icon(Icons.account_circle),
            ),
            tooltip: 'Log in',
            onPressed: () => _handleSignIn(),
          );
        }
        final userName = user.displayName != null ? user.displayName : '';
        final List<String> split = userName.split(' ');
        final String initials = split.length > 0
            ? split
                .map((s) => s[0].toUpperCase())
                .take(min(split.length, 2))
                .join('')
            : '';

        if (user.photoURL == null || user.photoURL.length == 0) {
          return GestureDetector(
            child: CircleAvatar(child: Text(initials)),
            onTap: () => _handleSignIn(),
          );
        }

        return PopupMenuButton<String>(
          child: user.photoURL != null && user.photoURL.length > 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL),
                  ),
                )
              : CircleAvatar(child: Text(initials)),
          tooltip: userName,
          onSelected: (String action) => _handleSignOut(),
          itemBuilder: (BuildContext context) {
            return <PopupMenuItem<String>>[
              PopupMenuItem(
                enabled: false,
                child: Row(
                  children: <Widget>[
                    user.photoURL != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(user.photoURL))
                        : null,
                    Spacer(flex: 1),
                    Text(userName,
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .body1
                                .color)),
                  ],
                ),
              ),
              PopupMenuItem(value: 'signOut', child: Text('Log out'))
            ];
          },
        );
      },
    );
  }

  void _handleSignIn() async {
    try {
      var user = await auth.signInWithGoogle();
      if (user == null) {
        throw ('user_canceled');
      }
      if (onUserChange != null) {
        onUserChange();
      }
    } catch (e) {
      if (e != 'user_canceled') {
        throw e;
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed.'),
          duration: Duration(seconds: 6),
        ),
      );
    }
  }

  _handleSignOut() async {
    await auth.requestSignOut();
    if (onUserChange != null) {
      onUserChange();
    }
  }
}
