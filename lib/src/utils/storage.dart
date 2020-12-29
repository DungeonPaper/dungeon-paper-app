import 'dart:io';

import 'package:dungeon_paper/db/db.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

Future<String> uploadImage(
  File imageFile, {
  @required String directory,
}) async {
  final fileName = basename(imageFile.path);
  final firebaseStorageRef = storage.ref().child('$directory/$fileName');
  final uploadTask = await firebaseStorageRef.putFile(imageFile);
  final downloadURL = await uploadTask.ref.getDownloadURL();
  return downloadURL;
}
