import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Serializable {
  void deserializeData(Map<String, dynamic> data);
  Map<String, dynamic> serializeData();
}

abstract class FirebaseEntity implements Serializable {
  final DocumentReference ref;
  String docID;
  DocumentSnapshot snapshot;
  DateTime lastUpdated;

  FirebaseEntity({
    this.ref,
    Map<String, dynamic> data,
  }) : docID = ref?.documentID {
    initEmptyData();

    if (data != null && data.isNotEmpty) {
      var defaults = toJSON();
      deserializeData(
        data.map((k, v) => defaults.keys.contains(k) ? defaults[k] : data[k]),
      );
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

  void create([Map<String, dynamic> data]) => update(json: data);

  Future<void> update({Map<String, dynamic> json, bool save = true}) async {
    var current = toJSON();
    if (ref == null) {
      return _noRef();
    }
    if (json == null) {
      json = toJSON();
    }
    json['lastUpdated'] = DateTime.now();

    if (save) {
      await ref.updateData(current.keys == json.keys
          ? json
          : Map.fromEntries(
              current.keys.map((k) => MapEntry(k, json[k])),
            ));
      var newData = await ref.get();
      deserializeData(
        json.map((k, v) =>
            MapEntry(k, current.keys.contains(k) ? newData[k] : json[k])),
      );
    } else {
      deserializeData(
        current.keys == json.keys
            ? json
            : json.map((k, v) =>
                MapEntry(k, current.keys.contains(k) ? json[k] : current[k])),
      );
    }
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
