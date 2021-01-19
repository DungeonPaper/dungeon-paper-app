import 'dart:async';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/redux/auth_controller.dart';
import 'package:dungeon_paper/src/redux/characters/characters_controller.dart';
import 'package:dungeon_paper/src/redux/custom_classes/custom_classes_controller.dart';
import 'package:dungeon_paper/src/redux/users/user_controller.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
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
    authController.logout();
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
      userController.setCurrent(
        User.fromJson(user.data()).copyWith(ref: user.reference),
      );
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
      final chars = <Character>[];
      characters.docs.forEach(
        (character) {
          final data = character.data();

          // TODO move to own migrations manager
          if (data['useDefaultMaxHP'] != null && data['settings'] == null) {
            data['settings'] = {
              'useDefaultMaxHp': data.remove('useDefaultMaxHP')
            };
            character.reference.update(
              pick(data, ['settings', 'useDefaultMaxHP']),
            );
          }

          chars.add(
            Character.fromJson(
              data,
              ref: character.reference,
            ),
          );
        },
      );
      characterController.setAll(chars);
      // final lastCharId = userController.current.lastCharacterId;
      // final matchingChar = chars.firstWhere(
      //   (c) => c.documentID == lastCharId,
      //   orElse: () => null,
      // );
      // if (lastCharId != null && matchingChar != null) {
      //   characterController.current = matchingChar;
      // }
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

    customClassesController.setAll([
      for (final character in classes.docs)
        CustomClass(
          data: character.data(),
          ref: character.reference,
        ),
    ]);
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
    customClassesController.setAll([
      for (final character in campaigns.docs)
        CustomClass(
          data: character.data(),
          ref: character.reference,
        ),
    ]);
  });
  logger.d('Registered db campaigns listener');
}
