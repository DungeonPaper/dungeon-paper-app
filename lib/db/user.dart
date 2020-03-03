import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/user.dart';
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

  List<DocumentReference> characters;
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
        characters = List<DocumentReference>.from(v) ?? [];
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

void unsetCurrentUser() async {
  print('Unsetting user');
  dwStore.dispatch(UserActions.logout());
}

Future<DocumentReference> createNewUser(FirebaseUser user) async {
  var userDoc = Firestore.instance.collection('user_data').document(user.email);
  var dbUser = User(ref: userDoc);
  await userDoc.setData(dbUser.toJSON());
  return userDoc;
}
