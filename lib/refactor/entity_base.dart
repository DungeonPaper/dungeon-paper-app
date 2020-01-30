import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Serializable {
  getData();
  deserializeData(Map<String, dynamic> data);
  serializeData();
}

abstract class FirebaseEntity implements Serializable {
  final DocumentReference ref;
  final String docID;
  DocumentSnapshot snapshot;
  DateTime lastUpdated;

  FirebaseEntity([this.ref]) : docID = ref?.documentID {
    if (ref != null) {
      getData();
    } else {
      initEmptyData();
    }
  }

  void getData() async {
    snapshot = await ref.get();
    deserializeData(snapshot.data);
    lastUpdated = snapshot.data['lastUpdated'];
  }

  void initEmptyData() {
    deserializeData(defaultData());
  }

  Map<String, dynamic> defaultData();
}
