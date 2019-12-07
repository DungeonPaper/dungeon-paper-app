import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:pedantic/pedantic.dart';

import '../redux/actions.dart';
import '../utils.dart';
import 'character.dart';
import 'character_utils.dart';
import 'user.dart';

Future<DbCharacter> setCurrentCharacterById(String documentId) async {
  DocumentSnapshot character =
      await Firestore.instance.document('character_bios/$documentId').get();
  DbCharacter dbCharacter = DbCharacter(character.data);

  dwStore.dispatch(
    CharacterActions.setCurrentChar(character.documentID, dbCharacter),
  );

  return dbCharacter;
}

Future<Map<String, DbCharacter>> getAllCharacters(DocumentSnapshot user) async {
  Map<String, Future<DocumentSnapshot>> refs = {};
  Map<String, DbCharacter> chars = {};
  user.data['characters'].forEach((char) {
    refs[char.documentID] =
        Firestore.instance.document('character_bios/${char.documentID}').get();
  });

  List<DocumentSnapshot> results = await Future.wait(refs.values);

  results.forEach((r) async {
    var char = DbCharacter(r.data);
    var migration = await checkAndPerformCharMigration(r.documentID, r.data);
    if (migration != null) {
      chars[r.documentID] = migration;
    } else {
      chars[r.documentID] = char;
    }
  });

  dwStore.dispatch(CharacterActions.setCharacters(chars));
  return chars;
}

unsetCurrentCharacter() async {
  print('Unsetting characters');
  dwStore.dispatch(CharacterActions.remove());
}

Future<DbCharacter> updateCharacter(
    DbCharacter character, List<CharacterKeys> updatedKeys,
    [String docId]) async {
  if (updatedKeys.isEmpty) {
    return character;
  }
  Firestore firestore = Firestore.instance;

  final String charDocId = docId ?? dwStore.state.characters.currentCharDocID;
  Map<String, DbCharacter> characters = dwStore.state.characters.characters;
  Map<String, dynamic> json = character.toJSON();
  Map<String, dynamic> output = {
    enumName(CharacterKeys.lastUpdateDt): Timestamp.now(),
  };
  updatedKeys.forEach((k) {
    String ck = enumName(k);
    output[ck] = json[ck];
  });
  characters[charDocId] = character;
  dwStore.dispatch(CharacterActions.setCharacters(characters));

  print('Updating character: $output');
  final charDoc = firestore.document('character_bios/$charDocId');
  unawaited(charDoc.updateData(output));
  final charData = await charDoc.get();

  return DbCharacter(charData.data);
}

deleteCharacter() async {
  String userDocId = dwStore.state.user.currentUserDocID;
  String charDocId = dwStore.state.characters.currentCharDocID;
  DbUser user = dwStore.state.user.current;
  if (user.characters.length == 1) {
    throw ("Can't delete last character.");
  }
  user.characters.removeWhere((d) => d.documentID == charDocId);
  var characters = dwStore.state.characters.characters
    ..removeWhere((k, v) => k == charDocId);
  await Firestore.instance
      .document('users/$userDocId')
      .updateData({'characters': user.characters});
  await Firestore.instance.document('character_bios/$charDocId').delete();
  dwStore.dispatch(CharacterActions.setCharacters(characters));
}

Future<DocumentReference> createNewCharacter([DbCharacter character]) async {
  character ??= DbCharacter();

  String userDocId = dwStore.state.user.currentUserDocID;
  DocumentReference userDoc = Firestore.instance.document('users/$userDocId');
  DocumentSnapshot user = await userDoc.get();
  List characters = List.from(user.data['characters'], growable: true);

  if (characters == null) {
    characters = [];
  }

  try {
    var json = character.toJSON().map((k, v) => MapEntry(enumName(k), v));

    DocumentReference charDoc =
        firestore.collection('character_bios').document();
    unawaited(charDoc.setData(json));
    characters.add(charDoc);
    unawaited(userDoc.updateData({'characters': characters}));
    dwStore.dispatch(
      CharacterActions.setCurrentChar(charDoc.documentID, character),
    );

    return charDoc;
  } catch (e) {
    print(e);
    return null;
  }
}

getOrCreateCharacter(DocumentSnapshot userSnap) async {
  if (userSnap.data['characters'].isNotEmpty) {
    print('userSnap data:' + userSnap.data['characters'][0].documentID);
    await getAllCharacters(userSnap);

    var lastCharId = dwStore.state.prefs.user.lastCharacterId;
    DocumentReference lastChar =
        (userSnap.data['characters'] as List).firstWhere(
      (d) => lastCharId == null || d.documentID == lastCharId,
      orElse: () => userSnap.data['characters'][0],
    );
    return setCurrentCharacterById(lastChar.documentID);
  } else {
    DbCharacter char =
        await setCurrentCharacterById((await createNewCharacter()).documentID);
    return char;
  }
}

Future<DbCharacter> checkAndPerformCharMigration(
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
  return updateCharacter(DbCharacter(character), keys, docId);
}
