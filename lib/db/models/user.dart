import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';

import 'character.dart';
import 'firebase_entity/fields/fields.dart';
import 'firebase_entity/firebase_entity.dart';

FieldsContext userFields = FieldsContext([
  StringField(fieldName: 'displayName'),
  StringField(fieldName: 'email'),
  StringField(fieldName: 'photoURL'),
  MapOfField<String, dynamic>(
    fieldName: 'features',
    field: Field<dynamic>(fieldName: 'features', defaultValue: (ctx) => null),
  ),
]);

class User extends FirebaseEntity {
  FieldsContext _fields;
  @override
  FieldsContext get fields => _fields ??= userFields.copy();
  String get displayName => fields.get<String>('displayName').get;
  set displayName(val) => fields.get<String>('displayName').set(val);
  String get email => fields.get<String>('email').get;
  set email(val) => fields.get<String>('email').set(val);
  String get photoURL => fields.get<String>('photoURL').get;
  set photoURL(val) => fields.get<String>('photoURL').set(val);
  Map<String, dynamic> get features =>
      fields.get<Map<String, dynamic>>('features').get;

  bool hasFeature(String key) =>
      features.containsKey(key) &&
      features[key] != false &&
      features[key] != null;

  User({
    DocumentReference ref,
    Map<String, dynamic> data,
    bool autoLoad,
  }) : super(ref: ref, data: data, autoLoad: autoLoad);

  Future<Character> createCharacter(Character character) async {
    var doc = firestore.collection(ref.path + '/characters').document();
    var data = character.toJSON();
    print('Creating character: $data');
    await doc.setData(data);
    character..ref = doc;
    dwStore.dispatch(UpsertCharacter(character));
    dwStore.dispatch(SetCurrentChar(character));
    return character;
  }

  @override
  void finalizeUpdate(Map<String, dynamic> json, {bool save = true}) {
    if (save) {
      dwStore.dispatch(SetUser(this));
    }
    super.finalizeUpdate(json, save: save);
  }

  @override
  String toString() => '$displayName ($email)';
}
