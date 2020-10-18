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

StreamSubscription _fbUserChangeListener;
StreamSubscription _fbUserUpdateListener;

void registerFirebaseUserListener() {
  try {
    _fbUserChangeListener?.cancel();
    _fbUserUpdateListener?.cancel();

    _fbUserChangeListener = auth.authStateChanges().listen((fbUser) {
      _fbUserUpdateListener?.cancel();
      if (fbUser != null) {
        _fbUserUpdateListener = auth.userChanges().listen(_setFbUser);
      }
      _setFbUser(fbUser);
    });
    logger.d('Registered auth user listener');
  } catch (e) {
    logger.d('error on user listener');
    _fbUserChangeListener?.cancel();
    logger.d("Couldn't register auth user listener");
  }
}

void _setFbUser(fb.User fbUser) {
  if (fbUser != null) {
    dwStore.dispatch(SetFirebaseUser(fbUser));
  } else {
    dwStore.dispatch(Logout());
    dwStore.dispatch(ClearCharacters());
  }
}

StreamSubscription _userListener;

void registerUserListener(fb.User fbUser) {
  _userListener?.cancel();

  if (fbUser == null) {
    return;
  }

  final userDocID = 'user_data/${fbUser.email}';
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

  logger.d('Registered db user listener');
}

StreamSubscription _charsListener;

void registerCharactersListener() async {
  if (_charsListener != null) {
    unawaited(_charsListener.cancel());
  }

  if (dwStore.state.user.current == null) {
    return;
  }

  final userDocID = dwStore.state.user.current.documentID;
  final user = firestore.doc('user_data/$userDocID');
  _charsListener =
      user.collection('characters').snapshots().listen((characters) {
    if (characters.docs.isEmpty) {
      return;
    }
    final chars = {
      for (final character in characters.docs)
        character.reference.id: Character(
          data: character.data(),
          ref: character.reference,
        ),
    };
    dwStore.dispatch(
      SetCharacters(chars),
    );
    final lastCharId = dwStore.state.prefs.user.lastCharacterId;
    final matchingChar = chars[lastCharId];
    if (lastCharId != null && matchingChar != null) {
      dwStore.dispatch(SetCurrentChar(matchingChar));
    }
  });
  logger.d('Registered db character listener');
}

StreamSubscription _classesListener;
void registerCustomClassesListener() async {
  if (_classesListener != null) {
    unawaited(_classesListener.cancel());
  }

  if (dwStore.state.user.current == null) {
    return;
  }

  final userDocID = dwStore.state.user.current.documentID;
  final user = firestore.doc('user_data/$userDocID');
  _classesListener =
      user.collection('custom_classes').snapshots().listen((classes) {
    if (classes.docs.isEmpty) {
      return;
    }
    dwStore.dispatch(
      SetCustomClasses({
        for (final character in classes.docs)
          character.reference.id: CustomClass(
            data: character.data(),
            ref: character.reference,
          ),
      }),
    );
  });
  logger.d('Registered db classes listener');
}
