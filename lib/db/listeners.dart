import 'dart:async';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/custom_classes/custom_classes_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:pedantic/pedantic.dart';

import 'models/character.dart';
import 'models/user.dart';

StreamSubscription _fbUserListener;

void registerFirebaseUserListener() {
  try {
    if (_fbUserListener != null) {
      _fbUserListener.cancel();
    }

    _fbUserListener = auth.authStateChanges().listen((authUser) {
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
    logger.d('REGISTERED AUTH USER LISTENER');
  } catch (e) {
    logger.d('error on user listener');
    if (_fbUserListener != null) {
      _fbUserListener.cancel();
    }
    logger.d("COULDN'T REGISTER AUTH USER LISTENER");
  }
}

StreamSubscription _userListener;

void registerUserListener(fb.User fbUser) {
  if (_userListener != null) {
    _userListener.cancel();
  }

  if (fbUser == null) {
    return;
  }

  var userDocID = 'user_data/${fbUser.email}';
  _userListener = firestore.doc(userDocID).snapshots().listen((user) {
    dwStore.dispatch(
      SetUser(
        User(
          data: user.data(),
          ref: user.reference,
        ),
      ),
    );
  });

  logger.d('REGISTERED DB USER LISTENER');
}

StreamSubscription _charsListener;

void registerCharactersListener() async {
  if (_charsListener != null) {
    unawaited(_charsListener.cancel());
  }

  if (dwStore.state.user.current == null) {
    return;
  }

  var userDocID = dwStore.state.user.current.documentID;
  var user = firestore.doc('user_data/$userDocID');
  _charsListener =
      user.collection('characters').snapshots().listen((characters) {
    if (characters.docs.isEmpty) {
      return;
    }
    var chars = {
      for (var character in characters.docs)
        character.reference.id: Character(
          data: character.data(),
          ref: character.reference,
        ),
    };
    dwStore.dispatch(
      SetCharacters(chars),
    );
    var lastCharId = dwStore.state.prefs.user.lastCharacterId;
    var matchingChar = chars[lastCharId];
    if (lastCharId != null && matchingChar != null) {
      dwStore.dispatch(SetCurrentChar(matchingChar));
    }
  });
  logger.d('REGISTERED DB CHARACTER LISTENER');
}

StreamSubscription _classesListener;
void registerCustomClassesListener() async {
  if (_classesListener != null) {
    unawaited(_classesListener.cancel());
  }

  if (dwStore.state.user.current == null) {
    return;
  }

  var userDocID = dwStore.state.user.current.documentID;
  var user = firestore.doc('user_data/$userDocID');
  _classesListener =
      user.collection('custom_classes').snapshots().listen((classes) {
    if (classes.docs.isEmpty) {
      return;
    }
    dwStore.dispatch(
      SetCustomClasses({
        for (var character in classes.docs)
          character.reference.id: CustomClass(
            data: character.data(),
            ref: character.reference,
          ),
      }),
    );
  });
  logger.d('REGISTERED DB CLASSES LISTENER');
}
