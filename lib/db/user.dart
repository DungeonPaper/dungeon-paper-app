import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbUser extends DbBase {
  final defaultData = {
    'characters': [],
    'displayName': 'Guest',
    'photoURL': null,
    'email': 'your@gmail.com',
  };

  DbUser([Map map]) : super(map);

  List get characters {
    return get<List>('characters');
  }

  String get displayName {
    return get<String>('displayName');
  }

  String get photoURL {
    return get<String>('photoURL');
  }

  String get email {
    return get<String>('email');
  }
}

FirebaseUser authUser;
DbUser currentUser = DbUser({});

Future<DbUser> setCurrentUserByField(String searchField, String searchValue) async {
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
