import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/character.dart';
import '../redux/actions.dart';

Future<Character> setCurrentCharacterById(String documentId) async {
  DocumentSnapshot character = await firestore.document(documentId).get();
  Character dbCharacter =
      Character(ref: character.reference, data: character.data);

  dwStore.dispatch(
    CharacterActions.setCurrentChar(character.documentID, dbCharacter),
  );

  return dbCharacter;
}
