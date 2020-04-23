import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/refactor/custom_class.dart';
import 'package:dungeon_paper/refactor/firebase_entity/fields/fields.dart';
import 'package:dungeon_paper/refactor/user.dart';
import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_world_data/player_class.dart';

final _db = Firestore.instance;

var _userWithChildrenFields = userFields.copyWith([
  Field<List<Character>>(
    fieldName: 'characters',
    defaultValue: (ctx) => [],
    toJSON: (chars, ctx) => chars.map(
      (char) => char.toJSON(),
    ),
    fromJSON: (chars, ctx) {
      var output = chars.map<Character>((char) {
        print('character: ${char['data']['displayName']}');
        var output = Character(
          ref: _db.document(char['docID']),
          data: char['data'],
        );
        print('char type ${output.runtimeType}');
        return output;
      }).toList();
      print('type ${output.runtimeType}');
      return output;
    },
  ),
  Field<List<Character>>(
    fieldName: 'custom_classes',
    defaultValue: (ctx) => [],
    toJSON: (customClasses, ctx) => customClasses.map(
      (cls) => cls.toJSON(),
    ),
    fromJSON: (chars, ctx) {
      var output = chars.map<PlayerClass>((char) {
        print('character: ${char['data']['displayName']}');
        var output = CustomClass(
          ref: _db.document(char['docID']),
          data: char['data'],
        );
        print('char type ${output.runtimeType}');
        return output;
      }).toList();
      print('type ${output.runtimeType}');
      return output;
    },
  ),
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
