import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/listeners.dart';
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
  DbUser([Map map])
      : super(map, defaultData: {
          'characters': [],
          'displayName': 'Guest',
          'photoURL': null,
          'email': 'your@gmail.com',
        }, listProperties: [
          'characters',
        ]);

  List get characters => get<List>('characters');
  String get displayName => get<String>('displayName');
  String get photoURL => get<String>('photoURL');
  String get email => get<String>('email');

  @override
  Map<String, dynamic> toJSON() {
    return {
      'characters': characters,
      'displayName': displayName,
      'photoURL': photoURL,
      'email': email,
    };
  }
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
  await getOrCreateCharacter(userDoc);
  registerDbUserListener();
  registerDbCharsListener();
}

unsetCurrentUser() async {
  print('Unsetting user');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('userId');
  prefs.remove('CharacterId');
  prefs.remove('userEmail');
  dwStore.dispatch(UserActions.logout());
}
