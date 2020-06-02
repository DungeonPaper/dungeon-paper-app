import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'fields/fields.dart';

abstract class FirebaseEntity {
  DocumentReference ref;
  String docID;
  DocumentSnapshot snapshot;
  DateTime lastUpdated;
  FieldsContext get fields;

  FirebaseEntity({
    this.ref,
    Map<String, dynamic> data,
    bool autoLoad = false,
  }) : docID = ref?.documentID {
    if (data != null && data.isNotEmpty) {
      var dataWithDefaults = _mergeDataWithDefaults(data);
      deserializeData(dataWithDefaults);
      lastUpdated = data['lastUpdated'] != null
          ? data['lastUpdated'] is Timestamp
              ? (data['lastUpdated'] as Timestamp).toDate()
              : DateTime.fromMillisecondsSinceEpoch(
                  data['lastUpdated']['_seconds'] * 1000)
          : null;
    } else if (ref != null && autoLoad == true) {
      getRemoteData();
    } else {
      deserializeData(defaultData());
    }
    fields.setDirty(false);
  }

  Map<String, dynamic> _mergeDataWithDefaults(Map<String, dynamic> data) {
    var defaults = defaultData();
    var dataWithDefaults = Map<String, dynamic>.from(defaults)
      ..addEntries([
        for (var key in defaults.keys)
          if (data.containsKey(key)) MapEntry(key, data[key])
      ]);
    return dataWithDefaults;
  }

  @mustCallSuper
  Future<Map<String, dynamic>> getRemoteData() async {
    var output = <String, dynamic>{};
    snapshot = await ref.get();
    if (snapshot != null && snapshot.data != null) {
      var data = _mergeDataWithDefaults(snapshot.data);
      output = await deserializeData(data);
      lastUpdated = snapshot.data['lastUpdated'];
    }
    return output;
  }

  void delete() {
    if (ref == null) {
      return _noRef();
    }
    ref.delete();
  }

  void create([Map<String, dynamic> data]) => update(json: data);

  Future<void> update({Map<String, dynamic> json, bool save = true}) async {
    json = prepareUpdate(json);
    setFields(json);
    finalizeUpdate(json, save: save);
  }

  Map<String, dynamic> prepareUpdate(Map<String, dynamic> json) {
    if (json == null) {
      json = Map.fromEntries(
        fields.dirtyFields.map(
          (k) => MapEntry(k, fields.get(k).toJSON()),
        ),
      );
    } else if (json.isNotEmpty) {
      json = prepareJSONUpdate(json);
    }
    json['lastUpdated'] = DateTime.now();
    return json;
  }

  void finalizeUpdate(Map<String, dynamic> json, {bool save = true}) async {
    if (save) {
      if (ref == null) {
        return _noRef();
      }
      print('Updating $this');
      print(json);
      await ref.updateData(json);
      unsetDirty(json);
    }
  }

  void setFields(Map<String, dynamic> json) {
    json.forEach((k, v) => fields[k]?.set(fields[k]?.fromJSON(v)));
  }

  void unsetDirty(Map<String, dynamic> json) {
    json.forEach((k, v) => fields[k]?.setDirty(false));
  }

  Map<String, dynamic> prepareJSONUpdate(Map<String, dynamic> json,
      {bool useSetter = true}) {
    var output = <String, dynamic>{};
    for (var k in json.keys) {
      var field = fields.get(k);
      var value = fields.get(k).fromJSON(json[k]);
      if (useSetter) {
        field.set(value);
      }
      output[field.outputFieldName] = field.toJSON();
    }
    return output;
  }

  void _noRef() {
    return null; // could also throw exception...?
  }

  Map<String, dynamic> deserializeData(Map<String, dynamic> data) {
    var output = <String, dynamic>{};
    for (var key in data.keys) {
      try {
        var field = fields.get(key);
        if (field == null) {
          continue;
        }
        var value = field.fromJSON(data[key]);
        field.set(value);
        output[key] = value;
      } catch (e) {
        print('[$runtimeType] Error deserializing key: $key');
        print('Given value: ${data[key]}');
        rethrow;
      }
    }
    return output;
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

  operator ==(o) => o is FirebaseEntity && o.docID == docID;
}
