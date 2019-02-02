import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/actions/character_actions.dart';
import 'package:dungeon_paper/redux/actions/user_actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base.dart';
import 'package:firebase_auth/firebase_auth.dart';

final Firestore firestore = Firestore.instance;
FirebaseUser authUser;
DbUser currentUser = DbUser({});
StreamSubscription listener;

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

setCurrentUserByEmail(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  QuerySnapshot userQuery = await Firestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .getDocuments();

  if (userQuery.documents.length == 0) {
    return;
  }

  DocumentSnapshot userDoc = userQuery.documents[0];
  DbUser dbUser = DbUser(userDoc.data);

  prefs.setString('userId', userDoc.documentID);
  prefs.setString('userEmail', dbUser.email);

  dwStore.dispatch(UserActions.login(userDoc.documentID, dbUser));
  getOrCreateCharacter(userDoc);
}

unsetCurrentUser() async {
  print('Unsetting user');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('userId');
  prefs.remove('CharacterId');
  prefs.remove('userEmail');
  dwStore.dispatch(UserActions.logout());
}

registerUserListener() {
  try {
    if (listener != null) {
      listener.cancel();
    }

    listener = FirebaseAuth.instance.onAuthStateChanged
        .listen((FirebaseUser authUser) {
      if (authUser != null &&
          authUser.email != null &&
          authUser.email != dwStore.state.user.current.email) {
        setCurrentUserByEmail(authUser.email);
      }

      if (authUser == null || authUser.email == null) {
        unsetCurrentUser();
        unsetCurrentCharacter();
      }
    });
  } catch (e) {
    print('error on user listener');
    if (listener != null) {
      listener.cancel();
    }
  }
}
