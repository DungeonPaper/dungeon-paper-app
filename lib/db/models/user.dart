import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/custom_classes/custom_classes_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
import 'package:dungeon_paper/src/utils/auth/auth.dart';
import 'package:dungeon_paper/src/utils/logger.dart';

import 'character.dart';
import 'custom_class.dart';
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
      key != null &&
      features.containsKey(key) &&
      features[key] != false &&
      features[key] != null;

  bool featureEnabled(String key) =>
      features[key] is bool && features[key] == true;

  bool get isDm => featureEnabled('dm_tools_preview');

  bool get isTester => hasFeature('tester');

  User({
    DocumentReference ref,
    Map<String, dynamic> data,
    bool autoLoad,
  }) : super(ref: ref, data: data, autoLoad: autoLoad);

  Future<Character> createCharacter(Character character) async {
    var doc = firestore.collection(ref.path + '/characters').doc();
    var data = character.toJSON();
    logger.d('Creating character: $data');
    await doc.set(data);
    character..ref = doc;
    dwStore.dispatch(UpsertCharacter(character));
    dwStore.dispatch(SetCurrentChar(character));
    return character;
  }

  Future<CustomClass> createCustomClass(CustomClass cls) async {
    var doc = firestore.collection(ref.path + '/custom_classes').doc();
    var data = cls.toJSON();
    logger.d('Creating custom class: $data');
    await doc.set(data);
    cls..ref = doc;
    dwStore.dispatch(UpsertCustomClass(cls));
    return cls;
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

  Future<void> changeEmail(String newEmail) async {
    email = newEmail;
    await updateEmail(newEmail);
    return move(newEmail);
  }
}
