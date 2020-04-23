import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/refactor/firebase_entity/fields/fields.dart';
import 'package:dungeon_paper/refactor/user.dart';
import 'package:dungeon_paper/refactor/character.dart';

var _userWithChildrenFields = userFields.copyWith([
  CharacterListField(fieldName: 'characters'),
  PlayerClassListField(fieldName: 'custom_classes'),
]);

class UserWithChildren extends User {
  FieldsContext _fields;
  @override
  FieldsContext get fields => _fields ??= _userWithChildrenFields.copy();

  List<Character> get characters =>
      fields.get<List<Character>>('characters').get;

  UserWithChildren({
    DocumentReference ref,
    Map<String, dynamic> data,
  }) : super(ref: ref, data: data);
}
