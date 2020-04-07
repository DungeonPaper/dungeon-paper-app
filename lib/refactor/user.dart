import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_paper/refactor/firebase_entity/firebase_entity.dart';

Fields userFields = Fields([
  Field<String>(fieldName: 'displayName', defaultValue: (ctx) => ''),
  Field<String>(fieldName: 'email', defaultValue: (ctx) => ''),
  Field<String>(fieldName: 'photoURL', defaultValue: (ctx) => ''),
]);

class User extends FirebaseEntity {
  Fields _fields;
  @override
  Fields get fields => _fields ??= userFields.copy();
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

  Character createCharacter(Character character) {
    var doc = Firestore.instance.collection(docID + '/characters').document();
    doc.setData(character.toJSON());
    return character..docID = doc.path;
  }

  @override
  String toString() => '$displayName ($email)';
}
