import 'dart:async';
import 'dart:math';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/stores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class UserBadge extends StatefulWidget {
  const UserBadge({Key key}) : super(key: key);

  @override
  _UserBadgeState createState() => new _UserBadgeState();
}

class _UserBadgeState extends State<UserBadge> {
  @override
  Widget build(BuildContext context) {
    return new StoreProvider<Map>(
        store: userStore,
        child: new StoreConnector<Map, DbUser>(
          converter: (store) => store.state['data'],
          builder: (context, user) {
            if (user == null) {
              return IconButton(
                icon: CircleAvatar(
                  child: Icon(Icons.account_circle),
                ),
                tooltip: 'Log in',
                onPressed: () => _handleSignIn(),
              );
            }
            final userName = user.displayName;
            final List<String> split = userName.split(' ');
            final String initials = split.length > 0
                ? split
                    .map((s) => s[0].toUpperCase())
                    .take(min(split.length, 2))
                    .join('')
                : '';
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
                        CircleAvatar(
                            backgroundImage: NetworkImage(user.photoURL)),
                        Spacer(flex: 1),
                        Text(userName,
                            style: TextStyle(
                                color: Theme
                                    .of(context)
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
        ));
  }

  Future<FirebaseUser> _handleSignIn() async {
    return googleSignIn(context);
  }

  Future<bool> _handleSignOut() async {
    return googleSignOut(context);
  }
}
