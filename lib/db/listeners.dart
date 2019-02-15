import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions/user_actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:firebase_auth/firebase_auth.dart';

StreamSubscription authUserListener;

registerAuthUserListener() {
  print("REGISTER AUTH USER LISTENER");
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
  } catch (e) {
    print('error on user listener');
    if (authUserListener != null) {
      authUserListener.cancel();
    }
  }
}

StreamSubscription dbUserListener;

registerDbUserListener() {
  print("REGISTER DB USER LISTENER (${dwStore.state.user.currentUserDocID})");
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
}

StreamSubscription dbCharsListener;

registerDbCharsListener() {
  print("REGISTER DB CHARS LISTENER (${dwStore.state.user.currentUserDocID})");
  if (dbCharsListener != null) {
    dbCharsListener.cancel();
  }

  String userDocID = dwStore.state.user.currentUserDocID;
  DocumentReference user = Firestore.instance.document(userDocID);
  dbCharsListener = Firestore.instance
      .collection('character_bios')
      .where('user', isEqualTo: user)
      .snapshots()
      .listen((characters) {
    print('incoming! $characters');
    // dwStore.dispatch(UserActions.login(userDocID, DbUser(user.data)));
  });
}
