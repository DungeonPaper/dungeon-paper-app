import 'dart:async';
import 'dart:math';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/stores.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

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
        child: new StoreConnector<Map, Map>(
          converter: (store) => store.state,
          builder: (context, state) {
            if (state == null || state['id'] == null) {
              _getDetailsFromPrefs(context);
            }

            final DbUser user = state['data'];
            final userName = user != null ? user.displayName : null;
            final List<String> split = userName.split(' ');
            final String initials = split.length > 0
                ? split.map((s) => s[0].toUpperCase()).take(min(split.length, 2)).join('')
                : '';
            return new IconButton(
              icon: new CircleAvatar(
                child: new Text(initials),
              ),
              onPressed: () => _handleSignIn(),
            );
          },
        ));
  }

  _getDetailsFromPrefs(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('userEmail');
    String characterId = prefs.getString('characterId');

    if (userEmail == null || characterId == null) {
      return;
    }

    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(
          'Logging in with $userEmail...'),
      duration: new Duration(seconds: 4),
    ));

    DbUser user = await setCurrentUserByField('email', userEmail);
    DbCharacter character = await setCurrentCharacterById(characterId);

    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(
          'Logged in as ${user.displayName}\nCharacter: ${character.displayName}'),
      duration: new Duration(seconds: 4),
    ));
  }

  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print('Setting state: ${user.toString()}');

    DbUser dbUser = await setCurrentUserByField('email', user.email);
    DbCharacter dbCharacter = await setCurrentCharacterById(
        (dbUser.characters[0] as DocumentReference).documentID);

    Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text(
              'Logged in as ${user.displayName}\nCharacter: ${dbCharacter.displayName}'),
          duration: new Duration(seconds: 4),
        ));
    return user;
  }
}
