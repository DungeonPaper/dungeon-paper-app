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
  var user = User(
    ref: firestore.collection('user_data').document(fbUser.email),
    autoLoad: false,
  );
  var data = await user.getRemoteData();
  if (data.isEmpty) {
    unawaited(analytics.logSignUp(signUpMethod: signInMethod));
    user
      ..displayName = fbUser.displayName
      ..email = fbUser.email
      ..photoURL = fbUser.photoUrl;
    await user.create();
    await Character(
      ref: user.ref.collection('characters').document(),
      autoLoad: false,
    ).create();
  }
  return user;
}
