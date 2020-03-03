import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_paper/refactor/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pedantic/pedantic.dart';

StreamSubscription _fbUserListener;

registerFirebaseUserListener() {
  try {
    if (_fbUserListener != null) {
      _fbUserListener.cancel();
    }

    _fbUserListener = FirebaseAuth.instance.onAuthStateChanged
        .listen((FirebaseUser authUser) {
      if (authUser != null &&
          authUser.email != null &&
          dwStore.state.user.current != null &&
          authUser.email != dwStore.state.user.current.email) {
        dwStore.dispatch(UserActions.setFirebaseUser(authUser));
      }

      if (authUser == null || authUser.email == null) {
        unsetCurrentUser();
        dwStore.dispatch(CharacterActions.remove());
      }
    });
    print("REGISTERED AUTH USER LISTENER");
  } catch (e) {
    print('error on user listener');
    if (_fbUserListener != null) {
      _fbUserListener.cancel();
    }
    print("COULDN'T REGISTER AUTH USER LISTENER");
  }
}

StreamSubscription _userListener;

registerUserListener() {
  if (_userListener != null) {
    _userListener.cancel();
  }

  String userDocID = dwStore.state.user.currentUserDocID;
  _userListener =
      Firestore.instance.document(userDocID).snapshots().listen((user) {
    dwStore.dispatch(
      UserActions.setUser(
        User(
          data: user.data,
          ref: user.reference,
        ),
      ),
    );
  });
  print("REGISTERED DB USER LISTENER");
}

StreamSubscription _charsListener;

registerCharactersListener() async {
  if (_charsListener != null) {
    unawaited(_charsListener.cancel());
  }

  String userDocID = dwStore.state.user.current.docID;
  DocumentReference user = Firestore.instance.document('user_data/$userDocID');
  _charsListener =
      user.collection('characters').snapshots().listen((characters) {
    dwStore.dispatch(
      CharacterActions.setCharacters(
        Map.fromEntries(
          characters.documents.map(
            (character) => MapEntry(
              character.reference.path,
              Character(
                data: character.data,
                ref: character.reference,
              ),
            ),
          ),
        ),
      ),
    );
  });
  print("REGISTERED DB CHARACTER LISTENER");
}
