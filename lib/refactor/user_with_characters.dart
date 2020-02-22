
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/refactor/user.dart';
import 'package:dungeon_paper/refactor/character.dart';

class UserWithCharacters extends User {
  List<Character> characters;
  Firestore _db = Firestore.instance;

  UserWithCharacters([DocumentReference ref]) : super(ref);
  UserWithCharacters.fromData({
    DocumentReference ref,
    Map<String, dynamic> data,
  }) : super.fromData(ref: ref, data: data);

  @override
  Map<String, dynamic> defaultData() {
    return super.defaultData()
      ..addAll({
        'characters': [],
      });
  }

  @override
  deserializeData(Map<String, dynamic> data) {
    super.deserializeData(data);
    characters = data['characters'].map((char) => Character.fromData(
          ref: _db.document(char['docID']),
          data: char['data'],
        ));
  }

  @override
  Map<String, dynamic> toJSON() {
    return super.toJSON()
      ..addAll({
        'characters': characters.map((char) => char.toJSON()),
      });
  }
}
