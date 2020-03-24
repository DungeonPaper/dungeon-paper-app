import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/refactor/firebase_entity/firebase_entity.dart';
import 'package:dungeon_paper/refactor/user.dart';
import 'package:dungeon_paper/refactor/character.dart';

final _db = Firestore.instance;

var _userWithCharsFields = Fields()
  ..register((ctx) => [
        Field<List<Character>>(
          fieldName: 'characters',
          defaultValue: (ctx) => [],
          toJSON: (chars, ctx) => chars.map(
            (char) => char.toJSON(),
          ),
          fromJSON: (chars, ctx) => chars
              .map((char) => Character(
                    ref: _db.document(char['docID']),
                    data: char['data'],
                  ))
              .toList(),
        ),
      ]);

class UserWithCharacters extends User {
  Fields fields = _userWithCharsFields.copy();

  List<Character> get characters =>
      fields.get<List<Character>>('characters').get;

  UserWithCharacters({
    DocumentReference ref,
    Map<String, dynamic> data,
  }) : super(ref: ref, data: data);
}
