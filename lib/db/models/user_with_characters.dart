import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/models/user.dart';

import 'character.dart';
import 'firebase_entity/fields/fields.dart';

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
