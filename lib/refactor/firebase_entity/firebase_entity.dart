import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/refactor/firebase_entity/fields.dart';
export 'package:dungeon_paper/refactor/firebase_entity/fields.dart';

abstract class FirebaseEntity {
  final DocumentReference ref;
  String docID;
  DocumentSnapshot snapshot;
  DateTime lastUpdated;
  Fields get fields;

  FirebaseEntity({
    this.ref,
    Map<String, dynamic> data,
  }) : docID = ref?.documentID {
    deserializeData(defaultData());

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

  void delete() {
    if (ref == null) {
      return _noRef();
    }
    ref.delete();
  }

  void create([Map<String, dynamic> data]) => update(json: data);

  Future<void> update({Map<String, dynamic> json, bool save = true}) async {
    if (ref == null) {
      return _noRef();
    }
    if (json == null) {
      json = Map.fromEntries(
        fields.dirtyFields.map(
          (k) => MapEntry(k, fields.get(k).toJSON()),
        ),
      );
    } else {
      for (var k in json.keys) {
        fields.get(k).set(json[k]);
      }
    }
    json['lastUpdated'] = DateTime.now();

    if (save) {
      await ref.updateData(json);
    }

    deserializeData(json);
  }

  void _noRef() {
    return null; // could also throw exception...?
  }

  void deserializeData(Map<String, dynamic> data) {
    var values = toJSON();
    for (var key in data.keys) {
      var field = fields.get(key);
      var value = field.fromJSON(data[key], fields);
      values[key] = value;
      field.set(value);
    }
  }

  Map<String, dynamic> toJSON() {
    var json = <String, dynamic>{};
    fields.fields.forEach((field) {
      if (field.isSerialized) {
        json[field.fieldName] = field.toJSON();
      }
    });
    return json;
  }

  Map<String, dynamic> defaultData() {
    var json = <String, dynamic>{};

    fields.fields.forEach((field) {
      if (field.isSerialized) {
        json[field.fieldName] = field.defaultValue;
      }
    });
    return json;
  }

  Map<String, dynamic> serializeData() => toJSON();
}
