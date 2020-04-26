import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_paper/refactor/firebase_entity/fields/fields.dart';
import 'package:dungeon_paper/refactor/firebase_entity/firebase_entity.dart';

FieldsContext userFields = FieldsContext([
  StringField(fieldName: 'displayName'),
  StringField(fieldName: 'email'),
  StringField(fieldName: 'photoURL'),
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

  User({
    DocumentReference ref,
    Map<String, dynamic> data,
  }) : super(ref: ref, data: data);

  Future<Character> createCharacter(Character character) async {
    var doc = firestore.collection(ref.path + '/characters').document();
    var data = character.toJSON();
    print('Creating character: $data');
    await doc.setData(data);
    character
      ..docID = doc.documentID
      ..ref = doc;
    dwStore.dispatch(CharacterActions.addCharacter(character));
    dwStore.dispatch(CharacterActions.setCurrentChar(character));
    return character;
  }

  @override
  String toString() => '$displayName ($email)';
}
