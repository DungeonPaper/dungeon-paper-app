import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/character.dart';
import '../redux/actions.dart';

Future<Character> setCurrentCharacterById(String documentId) async {
  DocumentSnapshot snapshot = await firestore.document(documentId).get();
  Character character = Character(ref: snapshot.reference, data: snapshot.data);

  dwStore.dispatch(
    CharacterActions.setCurrentChar(character),
  );

  return character;
}
