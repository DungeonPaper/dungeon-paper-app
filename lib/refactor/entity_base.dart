import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Serializable {
  void deserializeData(Map<String, dynamic> data);
  Map<String, dynamic> serializeData();
}

abstract class FirebaseEntity implements Serializable {
  final DocumentReference ref;
  final String docID;
  DocumentSnapshot snapshot;
  DateTime lastUpdated;

  FirebaseEntity({
    this.ref,
    Map<String, dynamic> data,
  }) : docID = ref?.documentID {
    initEmptyData();
    if (data != null && data.isNotEmpty) {
      deserializeData(data);
      lastUpdated = data['lastUpdated'];
    } else if (ref != null) {
      _getRemoteData();
    }
  }

  void _getRemoteData() async {
    snapshot = await ref.get();
    if (snapshot != null && snapshot.data != null) {
      deserializeData(snapshot.data);
      lastUpdated = snapshot.data['lastUpdated'];
    }
  }

  void initEmptyData() {
    deserializeData(defaultData());
  }

  void delete() {
    if (ref == null) {
      return _noRef();
    }
    ref.delete();
  }

  void create([Map<String, dynamic> data]) {
    update(data: data, keys: data.keys);
  }

  void update({Map<String, dynamic> data, List<String> keys}) {
    if (ref == null) {
      return _noRef();
    }
    if (data == null) {
      data = toJSON();
    }
    if (keys == null) {
      keys = data.keys;
    }
    keys.add('lastUpdated');
    data['lastUpdated'] = DateTime.now();

    ref.updateData(keys == data.keys
        ? data
        : Map.fromEntries(
            keys.map((k) => MapEntry(k, data[k])),
          ));
  }

  void _noRef() {
    return null; // could also throw exception...?
  }

  // T getter<T>(T value, [T defaultValue]) => value ?? defaultValue;
  // void setter<T>(T value, void Function(T value) delegate, [T defaultValue]) {
  //   delegate(value ?? defaultValue);
  // }

  Map<String, dynamic> defaultData();
  Map<String, dynamic> toJSON();
  Map<String, dynamic> serializeData() => toJSON();
}
