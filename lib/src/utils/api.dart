import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:pedantic/pedantic.dart';

Future<User> getDatabaseUser(
  fb.User fbUser, {
  @required SignInMethod signInMethod,
}) async {
  if (fbUser == null) {
    return null;
  }
  var user = User(
    ref: firestore.collection('user_data').doc(fbUser.email),
    autoLoad: false,
  );
  var data = await user.getRemoteData();
  if (data.isEmpty) {
    unawaited(analytics.logSignUp(signUpMethod: signInMethod.name));
    user
      ..displayName = fbUser.displayName ?? fbUser.email
      ..email = fbUser.email
      ..photoURL = fbUser.photoURL;
    await user.create();
    await user.createCharacter(Character());
  }
  return user;
}
