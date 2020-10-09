import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_world_data/player_class.dart';

Future<DocumentReference> cerateCustomClass(PlayerClass playerClass) async {
  var json = playerClass.toJSON();
  var userDocId = dwStore.state.user.currentUserDocID;
  var doc = firestore.collection('custom_classes/${userDocId}').doc();
  await doc.set(json);
  return doc;
}

Future<DocumentReference> updateCustomClass(
    String docId, PlayerClass playerClass) async {
  var json = playerClass.toJSON();
  var userDocId = dwStore.state.user.currentUserDocID;
  var doc = firestore.collection('custom_classes/${userDocId}').doc(docId);
  await doc.update(json);
  return doc;
}

Future<List<DocumentSnapshot>> getCustomClasses() async {
  var user = dwStore.state.user.current;
  var docs = await firestore
      .collection('user_data/${user.email}/custom_classes')
      .get();
  return docs.docs;
}
