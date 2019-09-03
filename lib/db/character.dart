import 'package:dungeon_paper/db/character_utils.dart';
import 'package:dungeon_paper/db/inventory_items.dart';
import 'package:dungeon_paper/db/notes.dart';
import 'package:dungeon_paper/db/spells.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import './character_utils.dart';
import 'base.dart';

class DbCharacter with Serializer<CharacterKeys> {
  DbCharacter([Map map]) {
    map ??= {};
    initSerializeMap();
    serializeAll(CHARACTER_KEY_DB_MAPPING.map((k, v) => MapEntry(k, map[v])));
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
  num _con;
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

  num get con => _con;

  set con(num value) {
    _con = value;
    if (useDefaultMaxHP) maxHP = defaultMaxHP;
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

  num get defaultMaxHP => mainClass.baseHP + statModifier(con);

  @override
  toJSON() {
    return {
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.alignment]: enumName(alignment),
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.displayName]: displayName,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.mainClass]:
          mainClass.name.toLowerCase(),
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.photoURL]: photoURL,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.level]: level,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.currentHP]: currentHP,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.currentXP]: currentXP,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.maxHP]: maxHP,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.armor]: armor,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.str]: str,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.dex]: dex,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.con]: con,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.wis]: wis,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.int]: int,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.cha]: cha,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.moves]:
          moves.map((move) => move.toJSON()).toList(),
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.notes]:
          notes.map((note) => note.toJSON()).toList(),
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.spells]:
          spells.map((spell) => spell.toJSON()).toList(),
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.inventory]:
          inventory.map((item) => item.toJSON()).toList(),
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.docVersion]: docVersion,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.hitDice]: hitDice.toString(),
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.looks]: looks,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.race]: race?.toJSON(),
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.coins]: coins,
      CHARACTER_KEY_DB_MAPPING[CharacterKeys.useDefaultMaxHP]: useDefaultMaxHP,
    };
  }

  @override
  initSerializeMap([Map map]) {
    serializeMap = {
      CharacterKeys.mainClass: (v) => mainClass =
          v != null && dungeonWorld.classes.containsKey(v)
              ? dungeonWorld.classes[v]
              : dungeonWorld.classes['bard'],
      CharacterKeys.useDefaultMaxHP: (v) => useDefaultMaxHP = v ?? false,
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
      CharacterKeys.currentHP: (v) =>
          currentHP = v ?? maxHP ?? defaultMaxHP ?? 0,
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
  }
}
