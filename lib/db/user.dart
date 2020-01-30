import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/custom_classes_db.dart';
import 'package:dungeon_paper/db/listeners.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'character_db.dart';

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

void setCurrentUser(FirebaseUser user) async {
  QuerySnapshot userQuery = await Firestore.instance
      .collection('users')
      .where('email', isEqualTo: user.email)
      .getDocuments();

  DocumentSnapshot userSnap;
  if (userQuery.documents.isEmpty) {
    DocumentReference userDoc = await createNewUser(user);
    userSnap = await userDoc.get();
  } else {
    userSnap = userQuery.documents[0];
  }
  DbUser dbUser = DbUser(userSnap.data);

  dwStore.dispatch(UserActions.login(userSnap.documentID, dbUser));
  await getOrCreateCharacter(userSnap);
  var customClasses = {
    for (DocumentSnapshot cls in await getCustomClasses())
      cls.documentID: PlayerClass.fromJSON(cls.data),
  };
  dwStore.dispatch(SetCustomClasses(customClasses));
  registerDbUserListener();
  registerDbCharsListener();
}

void unsetCurrentUser() async {
  print('Unsetting user');
  dwStore.dispatch(UserActions.logout());
}

Future<DocumentReference> createNewUser(FirebaseUser user) async {
  DocumentReference userDoc = Firestore.instance.collection('users').document();
  await userDoc.setData({
    'email': user.email,
    'displayName': user.displayName,
    'photoURL': user.photoUrl,
    'characters': [],
  });
  return userDoc;
}
