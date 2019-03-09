import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/listeners.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'base.dart';
import 'package:firebase_auth/firebase_auth.dart';

final Firestore firestore = Firestore.instance;
FirebaseUser authUser;
DbUser currentUser = DbUser({});
StreamSubscription listener;

enum UserKeys { characters, displayName, photoURL, email }

class DbUser with Serializer<UserKeys> {
  DbUser([Map map]) {
    map ??= {};
    initSerializeMap({
      UserKeys.characters: map['characters'],
      UserKeys.displayName: map['displayName'],
      UserKeys.photoURL: map['photoURL'],
      UserKeys.email: map['email'],
    });
  }

  List characters;
  String displayName;
  String photoURL;
  String email;

  @override
  toJSON() {
    return {
      'characters': characters,
      'displayName': displayName,
      'photoURL': photoURL,
      'email': email,
    };
  }

  @override
  initSerializeMap([Map map]) {
    serializeMap = {
      UserKeys.characters: (v) {
        characters = v ?? [];
      },
      UserKeys.displayName: (v) {
        displayName = v ?? 'Guest';
      },
      UserKeys.photoURL: (v) {
        photoURL = v ?? '';
      },
      UserKeys.email: (v) {
        email = v ?? 'email@guest.com';
      },
    };
    serializeAll(map);
  }
}

setCurrentUserByEmail(String email) async {
  QuerySnapshot userQuery = await Firestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .getDocuments();

  if (userQuery.documents.length == 0) {
    return;
  }

  DocumentSnapshot userDoc = userQuery.documents[0];
  DbUser dbUser = DbUser(userDoc.data);

  dwStore.dispatch(UserActions.login(userDoc.documentID, dbUser));
  await getOrCreateCharacter(userDoc);
  registerDbUserListener();
  registerDbCharsListener();
}

unsetCurrentUser() async {
  print('Unsetting user');
  dwStore.dispatch(UserActions.logout());
}
