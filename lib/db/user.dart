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
  userStore.dispatch(Action(type: UserActions.Loading, payload: true));
  characterStore.dispatch(Action(type: CharacterActions.Loading, payload: true));
  FirebaseUser user = await _auth.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  DbUser dbUser = await setCurrentUserByField('email', user.email);
  userStore.dispatch(Action(type: UserActions.Loading, payload: false));

  if (dbUser.characters.length > 0) {
    await setCurrentCharacterById(dbUser.characters[0].documentID);
  } else {
    DbCharacter character = DbCharacter({});
    Firestore firestore = Firestore.instance;
    DocumentReference charDoc =
        await firestore.collection('character_bios').add(character.map);
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String userDocId = sharedPrefs.getString('userId');
    firestore.document('character_bios/$userDocId').updateData({
      'characters': [charDoc]
    });
    characterStore.dispatch(Action(
      type: CharacterActions.Change,
      payload: {
        'id': charDoc.documentID,
        'data': dbUser,
      },
    ));
  }
  characterStore.dispatch(Action(type: CharacterActions.Loading, payload: false));
  return user;
}
