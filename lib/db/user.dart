import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class DbUser extends DbBase {
  final defaultData = {
    'characters': [],
    'displayName': 'Guest',
    'photoURL': null,
    'email': 'your@gmail.com',
  };

  DbUser([Map map]) : super(map);

  List get characters => get<List>('characters');
  String get displayName => get<String>('displayName');
  String get photoURL => get<String>('photoURL');
  String get email => get<String>('email');
}

FirebaseUser authUser;
DbUser currentUser = DbUser({});

Future<DbUser> setCurrentUserByField(
    String searchField, String searchValue) async {
  QuerySnapshot userQuery = await Firestore.instance
      .collection('users')
      .where(searchField, isEqualTo: searchValue)
      .getDocuments();

  DocumentSnapshot userDoc =
      userQuery.documents.length > 0 ? userQuery.documents[0] : null;
  DbUser dbUser = DbUser(userDoc.data);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userId', userDoc.documentID);
  prefs.setString('userEmail', dbUser.email);

  userStore.dispatch(new Action(
      type: UserActions.Login,
      payload: {'id': userDoc.documentID, 'data': dbUser}));

  return dbUser;
}

Future<bool> googleSignOut(BuildContext context) async {
  try {
    await _googleSignIn.signOut();
    unsetCurrentUser();
    unsetCurrentCharacter();
    return true;
  } catch (e) {
    return false;
  }
}

unsetCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('userId');
  prefs.remove('CharacterId');
  prefs.remove('userEmail');
  currentUser = null;
  userStore.dispatch(Action(type: UserActions.Logout));
}

Future<FirebaseUser> googleSignIn(BuildContext context) async {
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
