import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/db/helpers/character_utils.dart';
import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/inventory_items.dart';
import 'package:dungeon_paper/db/models/notes.dart';
import 'package:dungeon_paper/db/models/spells.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/alignment.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/gear_choice.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/foundation.dart';
part 'field.dart';
part 'typed_fields.dart';
part 'dw_typed_fields.dart';

typedef FieldListener<T> = void Function(T, FieldsContext);

class FieldsContext {
  Map<String, FieldBase> _map = {};

  FieldsContext(Iterable<FieldBase> fields) {
    for (var field in fields) {
      addField(field);
    }
  }

  Map<String, dynamic> get currentData =>
      _map.map((k, v) => MapEntry(k, v.value));

  FieldBase<T> get<T>(String fieldName) => _map[fieldName];

  register(Iterable<FieldBase> Function(FieldsContext context) fields) {
    for (var field in fields(this)) {
      addField(field);
    }
  }

  addField(FieldBase field) {
    _map[field.fieldName] = field.copy(this);
  }

  void setDirty(bool state) {
    fields.forEach((field) {
      field.setDirty(state);
    });
  }

  Iterable<FieldBase> get fields => _map.values;
  Iterable<String> get keys => _map.keys;
  FieldBase operator [](String field) => _map[field];
  void operator []=(String field, dynamic value) => _map[field] = value;

  List<String> get dirtyFields => _map.entries
      .where((entry) => entry.value.isDirty == true)
      .map((entry) => entry.key)
      .toList();

  List<String> get cleanFields => _map.entries
      .where((entry) => entry.value.isDirty == false)
      .map((entry) => entry.key)
      .toList();

  FieldsContext copy() {
    return FieldsContext(_map.values);
  }

  FieldsContext copyWith(Iterable<FieldBase> fields) {
    var _copy = copy();
    for (var field in fields) {
      _copy.addField(field);
    }
    return _copy;
  }

  void addListener<L>(FieldListener<L> listener) {
    for (var key in keys) {
      get(key)?.addListener(listener);
    }
  }

  void removeListener<L>(FieldListener<L> listener) {
    for (var key in keys) {
      get(key)?.removeListener(listener);
    }
  }
}
