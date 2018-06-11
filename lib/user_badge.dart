import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return new IconButton(
      icon: new CircleAvatar(),
      color: _user != null ? Colors.red : Colors.blue,
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
    this._user = user;
    print("signed in " + user.displayName);
    return user;
  }
}
