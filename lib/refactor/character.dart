import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character_utils.dart';
import 'package:dungeon_paper/db/inventory_items.dart';
import 'package:dungeon_paper/db/notes.dart';
import 'package:dungeon_paper/db/spells.dart';
import 'package:dungeon_paper/refactor/entity_base.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';

class Character extends FirebaseEntity {
  Character([DocumentReference ref]) : super(ref);

  Alignment alignment;
  String displayName;
  PlayerClass mainClass;
  String mainClassKey;
  String photoURL;
  num level;
  num currentHP;
  num currentXP;
  num _maxHP;
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
  bool useDefaultMaxHP;

  num get strMod => statModifier(str);
  num get dexMod => statModifier(dex);
  num get conMod => statModifier(con);
  num get wisMod => statModifier(wis);
  num get intMod => statModifier(int);
  num get chaMod => statModifier(cha);
  num get maxHP => useDefaultMaxHP ? defaultMaxHP : _maxHP;

  set maxHP(value) {
    _maxHP = value;
  }

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

  num get defaultMaxHP => mainClass.baseHP + conMod;

  @override
  deserializeData(Map<String, dynamic> data) {
    displayName = data['displayName'];
    photoURL = data['photoURL'];

    mainClass = dungeonWorld.classes.firstWhere(
        (c) => c.key == data['mainClass'],
        orElse: () => dungeonWorld.classes.first);

    str = data['str'];
    dex = data['dex'];
    con = data['con'];
    wis = data['wis'];
    int = data['int'];
    cha = data['cha'];
    alignment = stringToEnum<Alignment>(AlignmentNameMap)(data['alignment']);
    armor = data['armor'];
    hitDice = Dice.parse(data['hitDice']);
    looks = List.from(data['looks'] ?? []).map((i) => i.toString()).toList();
    race = Move.fromJSON(data['race']);
    coins = data['coins'];
    moves =
        List.from(data['moves'] ?? []).map((m) => Move.fromJSON(m)).toList();
    notes = List.from(data['notes'] ?? []).map((note) => Note(note)).toList();
    spells = List.from(data['spells'] ?? [])
        .map((spell) => DbSpell.fromJSON(spell))
        .toList();
    inventory = List.from(data['inventory'] ?? [])
        .map<InventoryItem>((item) => InventoryItem.fromJSON(item))
        .toList();

    useDefaultMaxHP = data['useDefaultMaxHP'];
    level = data['level'];
    currentXP = data['currentXP'];
    currentHP = data['currentHP'];
    _maxHP = data['maxHP'];
  }

  @override
  serializeData() {
    return {
      'alignment': enumName(alignment),
      'displayName': displayName,
      'mainClass': mainClass.name.toLowerCase(),
      'photoURL': photoURL,
      'level': level,
      'currentHP': currentHP,
      'currentXP': currentXP,
      'maxHP': _maxHP,
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
      'useDefaultMaxHP': useDefaultMaxHP,
    };
  }

  @override
  Map<String, dynamic> defaultData() {
    return {
      'alignment': Alignment.neutral,
      'displayName': 'Traveler',
      'mainClass': dungeonWorld.classes.first,
      'photoURL': null,
      'level': 1,
      'currentHP': 10,
      'currentXP': 0,
      'maxHP': 10,
      'armor': 0,
      'str': 8,
      'dex': 8,
      'con': 8,
      'wis': 8,
      'int': 8,
      'cha': 8,
      'moves': [],
      'notes': [],
      'spells': [],
      'inventory': [],
      'hitDice': Dice.d6,
      'looks': [],
      'race': (mainClass ?? dungeonWorld.classes.first).raceMoves.first,
      'coins': 0,
      'useDefaultMaxHP': true,
    };
  }
}
