import 'dart:io';

import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

Future<String> uploadImage(
  File imageFile, {
  @required String directory,
  Map<String, String> extraMetadata,
}) async {
  final fileName = basename(imageFile.path);
  final firebaseStorageRef = storage.ref().child('$directory/$fileName');
  final uploadTask = await firebaseStorageRef.putFile(
    imageFile,
    SettableMetadata(
      customMetadata: {
        'userId': dwStore.state.user.current.email,
        ...(extraMetadata ?? {}),
      },
    ),
  );
  final downloadURL = await uploadTask.ref.getDownloadURL();
  return downloadURL;
}
