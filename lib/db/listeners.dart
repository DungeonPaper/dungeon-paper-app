import 'dart:async';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/redux/auth_controller.dart';
import 'package:dungeon_paper/src/redux/characters/characters_controller.dart';
import 'package:dungeon_paper/src/redux/custom_classes/custom_classes_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_controller.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import 'models/character.dart';
import 'models/user.dart';

StreamSubscription _fbUserUpdateListener;

void registerFirebaseUserListener() {
  try {
    _fbUserUpdateListener?.cancel();

    _fbUserUpdateListener = auth.userChanges().listen(_setFbUser);
    logger.d('Registered auth user listener');
  } catch (e) {
    logger.d('error on user listener');
    _fbUserUpdateListener?.cancel();
    logger.d("Couldn't register auth user listener");
  }
}

void _setFbUser(fb.User fbUser) {
  if (fbUser != null) {
    authController.setFirebaseUser(fbUser);
    registerUserListener(fbUser);
    registerCharactersListener(fbUser);
    registerCustomClassesListener(fbUser);
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

  _userListener = firestore.doc('user_data/${fbUser.email}').snapshots().listen(
    (user) {
      userController.current =
          User.fromJson(user.data()).copyWith(ref: user.reference);
    },
  );

  logger.d('Registered db user listener');
}

StreamSubscription _charsListener;

void registerCharactersListener(fb.User firebaseUser) {
  _charsListener?.cancel();

  final userEmail = firebaseUser.email;
  final user = firestore.doc('user_data/$userEmail');

  _charsListener = user.collection('characters').snapshots().listen(
    (characters) {
      if (characters.docs.isEmpty) {
        return;
      }
      final chars = characters.docs.map(
        (character) => Character.fromJson(
          character.data(),
          ref: character.reference,
        ),
      );
      characterController.setAll(chars);
      final lastCharId = dwStore.state.prefs.user.lastCharacterId;
      final matchingChar = chars.firstWhere(
        (c) => c.documentID == lastCharId,
        orElse: () => null,
      );
      if (lastCharId != null && matchingChar != null) {
        characterController.current = matchingChar;
      }
    },
  );
  logger.d('Registered db character listener');
}

StreamSubscription _classesListener;
void registerCustomClassesListener(fb.User firebaseUser) {
  _classesListener?.cancel();
  final email = firebaseUser.email;
  _classesListener = firestore
      .collection('user_data/$email/custom_classes')
      .snapshots()
      .listen((classes) {
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

StreamSubscription _campaignsListener;

void registerCampaignsListener(fb.User firebaseUser) {
  _campaignsListener?.cancel();
  final email = firebaseUser.email;
  _campaignsListener = firestore
      .collection('user_data/$email/custom_campaigns')
      .snapshots()
      .listen((campaigns) {
    if (campaigns.docs.isEmpty) {
      return;
    }
    dwStore.dispatch(
      SetCustomClasses({
        for (final character in campaigns.docs)
          character.reference.id: CustomClass(
            data: character.data(),
            ref: character.reference,
          ),
      }),
    );
  });
  logger.d('Registered db campaigns listener');
}
