import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_world_data/player_class.dart';

Future<DocumentReference> cerateCustomClass(PlayerClass playerClass) async {
  var json = playerClass.toJSON();
  var userDocId = dwStore.state.user.currentUserDocID;
  var doc =
      Firestore.instance.collection('custom_classes/${userDocId}').document();
  await doc.setData(json);
  return doc;
}

Future<DocumentReference> updateCustomClass(
    String docId, PlayerClass playerClass) async {
  var json = playerClass.toJSON();
  var userDocId = dwStore.state.user.currentUserDocID;
  var doc = Firestore.instance
      .collection('custom_classes/${userDocId}')
      .document(docId);
  await doc.updateData(json);
  return doc;
}

Future<List<DocumentSnapshot>> getCustomClasses() async {
  var userDocId = dwStore.state.user.currentUserDocID;
  var docs = await Firestore.instance
      .collection('custom_classes').document(userDocId)
      .collection('classes')
      .getDocuments();
  return docs.documents;
}
