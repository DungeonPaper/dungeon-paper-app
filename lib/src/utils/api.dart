import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:pedantic/pedantic.dart';

Future<User> getDatabaseUser(
  FirebaseUser fbUser, {
  @required String signInMethod,
}) async {
  if (fbUser == null) {
    return null;
  }
  var user = User(
    ref: firestore.collection('user_data').document(fbUser.email),
    autoLoad: false,
  );
  var data = await user.getRemoteData();
  if (data.isEmpty) {
    unawaited(analytics.logSignUp(signUpMethod: signInMethod));
    user
      ..displayName = fbUser.displayName ?? fbUser.email
      ..email = fbUser.email
      ..photoURL = fbUser.photoUrl;
    await user.create();
    await user.createCharacter(Character());
  }
  return user;
}
