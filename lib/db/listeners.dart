import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/custom_classes/custom_classes_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pedantic/pedantic.dart';

import 'models/character.dart';
import 'models/user.dart';

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
        dwStore.dispatch(SetFirebaseUser(authUser));
      }

      if (authUser == null || authUser.email == null) {
        dwStore.dispatch(Logout());
        dwStore.dispatch(ClearCharacters());
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

registerUserListener(FirebaseUser fbUser) {
  if (_userListener != null) {
    _userListener.cancel();
  }

  if (fbUser == null) {
    return;
  }

  String userDocID = 'user_data/${fbUser.email}';
  _userListener = firestore.document(userDocID).snapshots().listen((user) {
    dwStore.dispatch(
      SetUser(
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

  if (dwStore.state.user.current == null) {
    return;
  }

  String userDocID = dwStore.state.user.current.documentID;
  DocumentReference user = firestore.document('user_data/$userDocID');
  _charsListener =
      user.collection('characters').snapshots().listen((characters) {
    if (characters.documents.isEmpty) {
      return;
    }
    dwStore.dispatch(
      SetCharacters({
        for (var character in characters.documents)
          character.reference.path: Character(
            data: character.data,
            ref: character.reference,
          ),
      }),
    );
  });
  print("REGISTERED DB CHARACTER LISTENER");
}

StreamSubscription _classesListener;
registerCustomClassesListener() async {
  if (_classesListener != null) {
    unawaited(_classesListener.cancel());
  }

  if (dwStore.state.user.current == null) {
    return;
  }

  String userDocID = dwStore.state.user.current.documentID;
  DocumentReference user = firestore.document('user_data/$userDocID');
  _classesListener =
      user.collection('custom_classes').snapshots().listen((classes) {
    if (classes.documents.isEmpty) {
      return;
    }
    dwStore.dispatch(
      SetCustomClasses({
        for (var character in classes.documents)
          character.reference.documentID: CustomClass(
            data: character.data,
            ref: character.reference,
          ),
      }),
    );
  });
  print("REGISTERED DB CLASSES LISTENER");
}
