import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:flutter/foundation.dart';

import 'fields/fields.dart';

abstract class FirebaseEntity {
  DocumentReference ref;
  DocumentSnapshot snapshot;
  DateTime lastUpdated;
  FieldsContext get fields;
  String get documentID => ref?.id;
  String get documentPath => ref?.path;

  FirebaseEntity({
    this.ref,
    Map<String, dynamic> data,
    bool autoLoad = false,
  }) {
    if (data != null && data.isNotEmpty) {
      var dataWithDefaults = _mergeDataWithDefaults(data);
      deserializeData(dataWithDefaults);
      lastUpdated = _getTimestamp(data['lastUpdated']);
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

  DateTime _getTimestamp(dynamic original) => original != null
      ? original is Timestamp
          ? original.toDate()
          : DateTime.fromMillisecondsSinceEpoch(original['_seconds'] * 1000)
      : null;

  @mustCallSuper
  Future<Map<String, dynamic>> getRemoteData() async {
    var output = <String, dynamic>{};
    snapshot = await ref.get();
    if (snapshot?.data() != null) {
      var data = _mergeDataWithDefaults(snapshot.data());
      output = await deserializeData(data);
      lastUpdated = _getTimestamp(data['lastUpdated']);
    }
    return output;
  }

  Future<void> delete() async {
    logger.d('Deleting $this');

    if (ref == null) {
      return _noRef();
    }

    await ref.delete();
  }

  Future<void> create() async {
    var data = toJSON();
    data = prepareData(data);
    setFields(data);
    finalizeCreate(data);
  }

  Future<void> update({Map<String, dynamic> json, bool save = true}) async {
    json = prepareData(json);
    setFields(json);
    finalizeUpdate(json, save: save);
  }

  Future<void> move(String newId, {bool useSameParent = true}) async {
    final oldRef = ref;
    ref = useSameParent ? ref.parent.doc(newId) : firestore.doc(newId);
    logger.d('Creating new document: ${ref.path}');
    await create();
    logger.d('Success. Deleting ${oldRef.path}');
    await oldRef.delete();
  }

  Map<String, dynamic> prepareData(Map<String, dynamic> json) {
    if (json == null) {
      json = Map.fromEntries(
        fields.dirtyFields.map(
          (k) => MapEntry(k, fields.get(k).toJSON()),
        ),
      );
    } else if (json.isNotEmpty) {
      json = prepareJSONUpdate(json);
    }
    return json;
  }

  void finalizeUpdate(Map<String, dynamic> json, {bool save = true}) async {
    if (save) {
      if (ref == null) {
        return _noRef();
      }
      logger.d('Updating $this');
      logger.d(json.toString());
      await ref.update({...json, 'lastUpdated': FieldValue.serverTimestamp()});
      unsetDirty(json);
    }
  }

  void finalizeCreate(Map<String, dynamic> json) async {
    if (ref == null) {
      return _noRef();
    }
    try {
      logger.d('Creating $this');
      logger.d(json);
    } catch (e, stack) {
      logger.e('Logging error', e, stack);
    }
    await ref.set({...json, 'lastUpdated': FieldValue.serverTimestamp()});
    unsetDirty(json);
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
    fields.init(data);
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
        logger.d('[$runtimeType] Error deserializing key: $key');
        logger.d('Given value: ${data[key]}');
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

  @override
  bool operator ==(o) => o is FirebaseEntity && o.documentID == documentID;
}
