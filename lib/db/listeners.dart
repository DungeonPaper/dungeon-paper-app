import 'dart:async';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/controllers/auth_controller.dart';
import 'package:dungeon_paper/src/controllers/characters_controller.dart';
import 'package:dungeon_paper/src/controllers/custom_classes_controller.dart';
import 'package:dungeon_paper/src/controllers/user_controller.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import 'migrations/character_migrations.dart';
import 'models/user.dart';

StreamSubscription _fbUserUpdateListener;
StreamSubscription _userListener;
StreamSubscription _charsListener;
StreamSubscription _classesListener;
StreamSubscription _campaignsListener;

void registerFirebaseUserListener() {
  try {
    _fbUserUpdateListener?.cancel();

    _fbUserUpdateListener = auth.userChanges().listen(_onAuthChange);
    logger.d('Registered auth user listener');
  } catch (e) {
    logger.d('error on user listener');
    _fbUserUpdateListener?.cancel();
    logger.d("Couldn't register auth user listener");
  }
}

void _onAuthChange(fb.User firebaseUser) {
  if (firebaseUser != null) {
    authController.setFirebaseUser(firebaseUser);
    registerUserListener(firebaseUser);
    registerCharactersListener(firebaseUser);
    registerCustomClassesListener(firebaseUser);
    registerCampaignsListener(firebaseUser);
  } else {
    _fbUserUpdateListener?.cancel();
    _userListener?.cancel();
    _charsListener?.cancel();
    _classesListener?.cancel();
    _campaignsListener?.cancel();
    authController.logout();
  }
}

void registerUserListener(fb.User firebaseUser) {
  _userListener?.cancel();

  if (firebaseUser == null) {
    return;
  }

  _userListener =
      firestore.doc('user_data/${firebaseUser.email}').snapshots().listen(
    (user) {
      userController.setCurrent(
        User.fromJson(user.data()).copyWith(ref: user.reference),
      );
    },
  );

  logger.d('Registered db user listener');
}

void registerCharactersListener(fb.User firebaseUser) {
  _charsListener?.cancel();
  if (firebaseUser == null) {
    return;
  }

  final userEmail = firebaseUser.email;
  final user = firestore.doc('user_data/$userEmail');

  _charsListener = user.collection('characters').snapshots().listen(
    (characters) async {
      if (characters.docs.isEmpty) {
        return;
      }
      final chars = await Future.wait(characters.docs.map(
        (character) => CharacterMigrations().run(character),
      ));
      characterController.setAll(chars);
    },
  );
  logger.d('Registered db character listener');
}

void registerCustomClassesListener(fb.User firebaseUser) {
  _classesListener?.cancel();
  if (firebaseUser == null) {
    return;
  }
  final email = firebaseUser.email;
  _classesListener = firestore
      .collection('user_data/$email/custom_classes')
      .snapshots()
      .listen((classes) {
    if (classes.docs.isEmpty) {
      return;
    }

    customClassesController.setAll([
      for (final character in classes.docs)
        CustomClass.fromJson(
          character.data(),
          ref: character.reference,
        ),
    ]);
  });
  logger.d('Registered db classes listener');
}

void registerCampaignsListener(fb.User firebaseUser) {
  _campaignsListener?.cancel();
  if (firebaseUser == null) {
    return;
  }
  final email = firebaseUser.email;
  _campaignsListener = firestore
      .collection('user_data/$email/campaigns')
      .snapshots()
      .listen((campaigns) {
    if (campaigns.docs.isEmpty) {
      return;
    }
    // TODO implement
    // customClassesController.setAll([
    //   for (final character in campaigns.docs)
    //     CustomClass.fromJson(
    //       character.data(),
    //       ref: character.reference,
    //     ),
    // ]);
  });
  logger.d('Registered db campaigns listener');
}
