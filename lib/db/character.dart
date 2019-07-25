import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character_types.dart';
import 'package:dungeon_paper/db/inventory_items.dart';
import 'package:dungeon_paper/db/notes.dart';
import 'package:dungeon_paper/db/spells.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'base.dart';

enum CharacterKeys {
  alignment,
  displayName,
  mainClass,
  photoURL,
  level,
  currentHP,
  currentXP,
  maxHP,
  armor,
  str,
  dex,
  con,
  wis,
  int,
  cha,
  moves,
  notes,
  spells,
  inventory,
  docVersion,
  hitDice,
  looks,
  race,
  coins,
}

class DbCharacter with Serializer<CharacterKeys> {
  DbCharacter([Map map]) {
    map ??= {};
    initSerializeMap({
      CharacterKeys.mainClass: map['mainClass'],
      CharacterKeys.str: map['str'],
      CharacterKeys.dex: map['dex'],
      CharacterKeys.con: map['con'],
      CharacterKeys.wis: map['wis'],
      CharacterKeys.int: map['int'],
      CharacterKeys.cha: map['cha'],
      CharacterKeys.alignment: map['alignment'],
      CharacterKeys.displayName: map['displayName'],
      CharacterKeys.photoURL: map['photoURL'],
      CharacterKeys.level: map['level'],
      CharacterKeys.currentHP: map['currentHP'],
      CharacterKeys.currentXP: map['currentXP'],
      CharacterKeys.maxHP: map['maxHP'],
      CharacterKeys.armor: map['armor'],
      CharacterKeys.moves: map['moves'],
      CharacterKeys.notes: map['notes'],
      CharacterKeys.spells: map['spells'],
      CharacterKeys.inventory: map['inventory'],
      CharacterKeys.docVersion: map['docVersion'],
      CharacterKeys.hitDice: map['hitDice'],
      CharacterKeys.looks: map['looks'],
      CharacterKeys.race: map['race'],
      CharacterKeys.coins: map['coins'],
    });
    mainClassKey = map['mainClass'];
  }

  Alignment alignment;
  String displayName;
  PlayerClass mainClass;
  String mainClassKey;
  String photoURL;
  num level;
  num currentHP;
  num currentXP;
  num maxHP;
  num armor;
  num str;
  num dex;
  num con;
  num wis;
  num int;
  num cha;
  List<Move> moves;
  List<Note> notes;
  List<DbSpell> spells;
  List<InventoryItem> inventory;
  num docVersion;
  Dice hitDice;
  List<String> looks;
  Move race;
  num coins;

  static num statModifier(num stat) {
    const modifiers = {1: -3, 4: -2, 6: -1, 9: 0, 13: 1, 16: 2, 18: 3};

    if (modifiers.containsKey(stat)) {
      return modifiers[stat];
    }

    for (num i = stat; i > 0; --i) {
      if (modifiers.containsKey(i)) {
        return modifiers[i];
      }
    }

    return -1;
  }

  static String statModifierText(num stat) {
    num mod = statModifier(stat);
    return (mod >= 0 ? '+' : '') + mod.toString();
  }

  num get defaultMaxHP => mainClass.baseHP + statModifier(con);

  @override
  toJSON() {
    return {
      'alignment': enumName(alignment),
      'displayName': displayName,
      'mainClass': mainClass.name.toLowerCase(),
      'photoURL': photoURL,
      'level': level,
      'currentHP': currentHP,
      'currentXP': currentXP,
      'maxHP': maxHP,
      'armor': armor,
      'str': str,
      'dex': dex,
      'con': con,
      'wis': wis,
      'int': int,
      'cha': cha,
      'moves': moves.map((move) => move.toJSON()).toList(),
      'notes': notes.map((note) => note.toJSON()).toList(),
      'spells': spells.map((spell) => spell.toJSON()).toList(),
      'inventory': inventory.map((item) => item.toJSON()).toList(),
      'docVersion': docVersion,
      'hitDice': hitDice.toString(),
      'looks': looks,
      'race': race?.toJSON(),
      'coins': coins,
    };
  }

  @override
  initSerializeMap([Map map]) {
    serializeMap = {
      CharacterKeys.mainClass: (v) => mainClass =
          v != null && dungeonWorld.classes.containsKey(v)
              ? dungeonWorld.classes[v]
              : dungeonWorld.classes['bard'],
      CharacterKeys.str: (v) => str = v ?? 8,
      CharacterKeys.dex: (v) => dex = v ?? 8,
      CharacterKeys.con: (v) => con = v ?? 8,
      CharacterKeys.wis: (v) => wis = v ?? 8,
      CharacterKeys.int: (v) => int = v ?? 8,
      CharacterKeys.cha: (v) => cha = v ?? 8,
      CharacterKeys.alignment: (v) => alignment = v != null
          ? stringToEnum<Alignment>(AlignmentNameMap)(v)
          : Alignment.neutral,
      CharacterKeys.displayName: (v) => displayName = v ?? 'New Traveler',
      CharacterKeys.photoURL: (v) => photoURL = v ?? '',
      CharacterKeys.level: (v) => level = v ?? 1,
      CharacterKeys.maxHP: (v) => maxHP = v ?? defaultMaxHP,
      CharacterKeys.currentHP: (v) => currentHP = v ?? maxHP ?? defaultMaxHP ?? 0,
      CharacterKeys.currentXP: (v) => currentXP = v ?? 0,
      CharacterKeys.armor: (v) => armor = v ?? 0,
      CharacterKeys.moves: (v) => moves =
          List.from(v ?? []).map((move) => Move.fromJSON(move)).toList(),
      CharacterKeys.notes: (v) =>
          notes = List.from(v ?? []).map((note) => Note(note)).toList(),
      CharacterKeys.spells: (v) => spells =
          List.from(v ?? []).map((spell) => DbSpell.fromJSON(spell)).toList(),
      CharacterKeys.inventory: (v) => inventory = List.from(v ?? [])
          .map<InventoryItem>((item) => InventoryItem.fromJSON(item))
          .toList(),
      CharacterKeys.docVersion: (v) => docVersion = v ?? 1,
      CharacterKeys.hitDice: (v) =>
          hitDice = v != null ? Dice.parse(v) : mainClass.damage,
      CharacterKeys.looks: (v) =>
          looks = List.from(v ?? []).map((i) => i.toString()).toList(),
      CharacterKeys.race: (v) =>
          race = v != null ? Move.fromJSON(v) : mainClass.raceMoves.first,
      CharacterKeys.coins: (v) => coins = v ?? 0,
    };
    serializeAll(map);
  }
}

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
  Firestore firestore = Firestore.instance;

  final String charDocId = docId ?? dwStore.state.characters.currentCharDocID;
  Map<String, DbCharacter> characters = dwStore.state.characters.characters;
  Map<String, dynamic> json = character.toJSON();
  Map<String, dynamic> output = {};
  updatedKeys.forEach((k) {
    String ck = enumName(k);
    output[ck] = json[ck];
  });
  characters[charDocId] = character;
  dwStore.dispatch(CharacterActions.setCharacters(characters));

  print('Updating character: $output');
  final charDoc = firestore.document('character_bios/$charDocId')
    ..updateData(output);
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

Future<DocumentReference> createNewCharacter() async {
  DbCharacter character = DbCharacter();

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
    charDoc.setData(json);
    characters.add(charDoc);
    userDoc.updateData({'characters': characters});
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
