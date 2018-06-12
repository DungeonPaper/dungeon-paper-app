import 'dart:async';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/stores.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class UserBadge extends StatefulWidget {
  const UserBadge({Key key}) : super(key: key);

  @override
  _UserBadgeState createState() => new _UserBadgeState();
}

class _UserBadgeState extends State<UserBadge> {
  FirebaseUser _user;

  @override
  Widget build(BuildContext context) {
    print('User:' + _user.toString());
    final initials = _user != null ?
      _user.displayName.splitMapJoin(
        new RegExp(r'[ ]'),
        onMatch: (_) => '',
        onNonMatch: (word) => word[0].toUpperCase()
      ).substring(0, 2)
      : '';
    return new IconButton(
      icon: new CircleAvatar(
        child: new Text(initials),
      ),
      onPressed: () => _handleSignIn(),
    );
  }

  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print('Setting state: ${user.toString()}');
    setState(() { _user = user; });

    QuerySnapshot userQuery =
        await Firestore.instance.collection('users').where('email', isEqualTo: user.email).getDocuments();

    DocumentSnapshot userDoc = userQuery.documents.length > 0 ? userQuery.documents[0] : null;

    DbUser dbUser = DbUser(userDoc.data);

    DocumentSnapshot character = await dbUser.characters[0].get();
    DbCharacter dbCharacter = DbCharacter(character.data);

    userStore
        .dispatch(new Action(type: UserActions.Login, payload: dbUser));

    characterStore
        .dispatch(new Action(type: CharacterActions.Set, payload: dbCharacter));

    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Logged in as ${user.displayName}.'),
      duration: new Duration(seconds: 4),
    ));
    return user;
  }
}
