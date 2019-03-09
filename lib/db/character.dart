import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character_types.dart';
import 'package:dungeon_paper/db/notes.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/utils.dart';
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
}

const Map<String, CharacterKeys> CharacterKeysMap = {
  'alignment': CharacterKeys.alignment,
  'displayName': CharacterKeys.displayName,
  'mainClass': CharacterKeys.mainClass,
  'photoURL': CharacterKeys.photoURL,
  'level': CharacterKeys.level,
  'currentHP': CharacterKeys.currentHP,
  'currentXP': CharacterKeys.currentXP,
  'maxHP': CharacterKeys.maxHP,
  'armor': CharacterKeys.armor,
  'str': CharacterKeys.str,
  'dex': CharacterKeys.dex,
  'con': CharacterKeys.con,
  'wis': CharacterKeys.wis,
  'int': CharacterKeys.int,
  'cha': CharacterKeys.cha,
  'moves': CharacterKeys.moves,
  'notes': CharacterKeys.notes,
};

class DbCharacter with Serializer<CharacterKeys> {
  DbCharacter([Map map]) {
    map ??= {};
    initSerializeMap({
      CharacterKeys.alignment: map['alignment'],
      CharacterKeys.displayName: map['displayName'],
      CharacterKeys.mainClass: map['mainClass'],
      CharacterKeys.photoURL: map['photoURL'],
      CharacterKeys.level: map['level'],
      CharacterKeys.currentHP: map['currentHP'],
      CharacterKeys.currentXP: map['currentXP'],
      CharacterKeys.maxHP: map['maxHP'],
      CharacterKeys.armor: map['armor'],
      CharacterKeys.str: map['str'],
      CharacterKeys.dex: map['dex'],
      CharacterKeys.con: map['con'],
      CharacterKeys.wis: map['wis'],
      CharacterKeys.int: map['int'],
      CharacterKeys.cha: map['cha'],
      CharacterKeys.moves: map['moves'],
      CharacterKeys.notes: map['notes'],
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

  @override
  toJSON() {
    return {
      'alignment': enumName(alignment),
      'displayName': displayName,
      'mainClass': mainClass.name,
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
    };
  }

  @override
  initSerializeMap([Map map]) {
    serializeMap = {
      CharacterKeys.alignment: (v) => alignment = v != null
          ? stringToEnum<Alignment>(AlignmentNameMap)(v)
          : Alignment.good,
      CharacterKeys.displayName: (v) => displayName = v ?? 'New Traveler',
      CharacterKeys.mainClass: (v) => mainClass =
          v != null ? dungeonWorld.classes[v] : dungeonWorld.classes['bard'],
      CharacterKeys.photoURL: (v) => photoURL = v ?? '',
      CharacterKeys.level: (v) => level = v ?? 1,
      CharacterKeys.currentHP: (v) => currentHP = v ?? maxHP ?? 0,
      CharacterKeys.currentXP: (v) => currentXP = v ?? 0,
      CharacterKeys.maxHP: (v) => maxHP = v ?? 20,
      CharacterKeys.armor: (v) => armor = v ?? 0,
      CharacterKeys.str: (v) => str = v ?? 8,
      CharacterKeys.dex: (v) => dex = v ?? 8,
      CharacterKeys.con: (v) => con = v ?? 8,
      CharacterKeys.wis: (v) => wis = v ?? 8,
      CharacterKeys.int: (v) => int = v ?? 8,
      CharacterKeys.cha: (v) => cha = v ?? 8,
      CharacterKeys.moves: (v) => moves =
          List.from(v ?? []).map((move) => Move.fromJSON(move)).toList(),
      CharacterKeys.notes: (v) =>
          notes = List.from(v ?? []).map((note) => Note(note)).toList(),
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

  results.forEach((r) {
    chars[r.documentID] = DbCharacter(r.data);
  });

  dwStore.dispatch(CharacterActions.setCharacters(chars));
  return chars;
}

unsetCurrentCharacter() async {
  print('Unsetting characters');
  dwStore.dispatch(CharacterActions.remove());
}

Future<Map> updateCharacter(
    DbCharacter character, List<CharacterKeys> updatedKeys) async {
  Firestore firestore = Firestore.instance;

  final String charDocId = dwStore.state.characters.currentCharDocID;
  Map<String, dynamic> json = character.toJSON();
  Map<String, dynamic> output = {};
  updatedKeys.forEach((k) {
    var ck = enumName(k);
    output[ck] = json[ck];
  });
  dwStore.dispatch(CharacterActions.setCurrentChar(charDocId, character));

  print('Updating character: $output');
  final charDoc = firestore.document('character_bios/$charDocId')
    ..updateData(output);
  final charData = await charDoc.get();

  return charData.data;
}

createNewCharacter() async {
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
  if (userSnap.data['characters'].length > 0) {
    print('userSnap data:' + userSnap.data['characters'][0].documentID);
    await getAllCharacters(userSnap);

    var lastCharId = dwStore.state.prefs.user.lastCharacterId;
    DocumentReference lastChar = userSnap.data['characters']
        .firstWhere((d) => lastCharId == null || d.documentID == lastCharId);
    return setCurrentCharacterById(lastChar.documentID);
  } else {
    return createNewCharacter();
  }
}
