import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:firebase_auth/firebase_auth.dart';

StreamSubscription authUserListener;

registerAuthUserListener() {
  try {
    if (authUserListener != null) {
      authUserListener.cancel();
    }

    authUserListener = FirebaseAuth.instance.onAuthStateChanged
        .listen((FirebaseUser authUser) {
      if (authUser != null &&
          authUser.email != null &&
          dwStore.state.user.current != null &&
          authUser.email != dwStore.state.user.current.email) {
        setCurrentUserByEmail(authUser.email);
      }

      if (authUser == null || authUser.email == null) {
        unsetCurrentUser();
        unsetCurrentCharacter();
      }
    });
    print("REGISTERED AUTH USER LISTENER");
  } catch (e) {
    print('error on user listener');
    if (authUserListener != null) {
      authUserListener.cancel();
    }
    print("COULDN'T REGISTER AUTH USER LISTENER");
  }
}

StreamSubscription dbUserListener;

registerDbUserListener() {
  if (dbUserListener != null) {
    dbUserListener.cancel();
  }

  String userDocID = dwStore.state.user.currentUserDocID;
  dbUserListener = Firestore.instance
      .document('users/$userDocID')
      .snapshots()
      .listen((user) {
    dwStore.dispatch(UserActions.login(userDocID, DbUser(user.data)));
  });
  print("REGISTERED DB USER LISTENER");
}

StreamSubscription dbCharsListener;

registerDbCharsListener() async {
  if (dbCharsListener != null) {
    dbCharsListener.cancel();
  }

  String userDocID = dwStore.state.user.currentUserDocID;
  DocumentReference user = Firestore.instance.document('users/$userDocID');
  dbCharsListener = Firestore.instance
      .collection('character_bios')
      .where('user', isEqualTo: user)
      .snapshots()
      .listen((characters) {
    Map<String, DbCharacter> updatedChars = dwStore.state.characters.characters;
    characters.documents.forEach((character) {
      updatedChars[character.documentID] = DbCharacter(character.data);
    });
    dwStore.dispatch(CharacterActions.setCharacters(updatedChars));
  });
  print("REGISTERED DB CHARACTER LISTENER");
}
