import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/character.dart';
import '../redux/actions.dart';
import '../utils.dart';
import 'character_utils.dart';

Future<Character> setCurrentCharacterById(String documentId) async {
  DocumentSnapshot character = await firestore.document(documentId).get();
  Character dbCharacter =
      Character(ref: character.reference, data: character.data);

  dwStore.dispatch(
    CharacterActions.setCurrentChar(character.documentID, dbCharacter),
  );

  return dbCharacter;
}

Future<Character> checkAndPerformCharMigration(
    String docId, Map character) async {
  List<CharacterKeys> keys = [];

  num lastVersion = 3;
  num curVersion = character[enumName(CharacterKeys.docVersion)] ?? 0;

  if (curVersion == lastVersion) {
    print("No migrations for '${character['displayName']}' ($docId)");
    return null;
  }

  Map<CharacterKeys, bool Function(dynamic obj)> predicateMap = {
    CharacterKeys.notes: (notes) =>
        notes != null &&
        notes.isNotEmpty &&
        notes.any((note) => note['key'] == null),
    CharacterKeys.inventory: (items) =>
        items != null &&
        items.isNotEmpty &&
        items.any((item) => item['key'] == null || item['item'] != null),
  };

  predicateMap.forEach((enumKey, predicate) {
    if (predicate == null) {
      return;
    }
    String key = enumName(enumKey);
    if (predicate(character[key])) {
      keys.add(enumKey);
    }
  });

  character[enumName(CharacterKeys.docVersion)] = lastVersion;
  keys.add(CharacterKeys.docVersion);

  print(
      "Performing migrations for '${character['displayName']}' ($docId): $keys");
  return Character(data: character, ref: null);
  // return updateCharacter(Character(data: character), keys, docId);
}
