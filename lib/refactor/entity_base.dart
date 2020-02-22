import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Serializable {
  deserializeData(Map<String, dynamic> data);
  serializeData();
}

abstract class FirebaseEntity implements Serializable {
  final DocumentReference ref;
  final String docID;
  DocumentSnapshot snapshot;
  DateTime lastUpdated;

  FirebaseEntity([this.ref]) : docID = ref?.documentID {
    initEmptyData();
    if (ref != null) {
      _getRemoteData();
    }
  }

  FirebaseEntity.fromData({
    Map<String, dynamic> data,
    this.ref,
  }) : docID = ref?.documentID {
    deserializeData(data);
    lastUpdated = (snapshot?.data ?? {})['lastUpdated'];
  }

  void _getRemoteData() async {
    snapshot = await ref.get();
    deserializeData(snapshot.data);
    lastUpdated = snapshot.data['lastUpdated'];
  }

  void initEmptyData() {
    deserializeData(defaultData());
  }

  Map<String, dynamic> defaultData();
  Map<String, dynamic> toJSON();
  Map<String, dynamic> serializeData() => toJSON();
}
