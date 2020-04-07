import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character_utils.dart';
import 'package:dungeon_paper/db/inventory_items.dart';
import 'package:dungeon_paper/db/notes.dart';
import 'package:dungeon_paper/db/spells.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/firebase_entity/firebase_entity.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:pedantic/pedantic.dart';

// Ordered by whichever data needs to come earliest for the rest to be able to calculate
Fields _charFields = Fields([
  //
  // Stats
  Field<num>(fieldName: 'armor', defaultValue: (ctx) => 0),
  Field<num>(fieldName: 'str', defaultValue: (ctx) => 8),
  Field<num>(fieldName: 'dex', defaultValue: (ctx) => 8),
  //
  // con needs to stay above mainClass & maxHP
  Field<num>(
    fieldName: 'con',
    defaultValue: (ctx) => 8,
  ),
  Field<num>(fieldName: 'wis', defaultValue: (ctx) => 8),
  Field<num>(fieldName: 'int', defaultValue: (ctx) => 8),
  Field<num>(fieldName: 'cha', defaultValue: (ctx) => 8), // Preferences
  Field<bool>(
    fieldName: 'useDefaultMaxHP',
    defaultValue: (ctx) => true,
  ),
  //
  // Class
  Field<PlayerClass>(
    fieldName: 'mainClass',
    defaultValue: (ctx) => dungeonWorld.classes.first,
    toJSON: (cls, ctx) => cls.key,
    fromJSON: (key, ctx) => dungeonWorld.classes.firstWhere(
      (c) => c.key == key,
      orElse: () => dungeonWorld.classes.first,
    ),
  ),
  Field<Alignment>(
    fieldName: 'alignment',
    defaultValue: (ctx) => Alignment.neutral,
    toJSON: (alignment, ctx) => enumName(alignment),
    fromJSON: (alignment, ctx) => AlignmentMap.entries
        .firstWhere((entry) => entry.value == alignment)
        .key,
  ),
  Field<num>(
    fieldName: 'maxHP',
    defaultValue: (ctx) {
      var _mainClassOriginal = ctx?.get<PlayerClass>('mainClass')?.value ??
          dungeonWorld.classes.first;
      var conMod = Character.statModifier(ctx?.get<num>('con')?.value ?? 8);
      return _mainClassOriginal.baseHP + conMod;
    },
  ),

  /// Rest are by no significant order
  Field<String>(
    fieldName: 'displayName',
    defaultValue: (ctx) => 'Traveler',
  ),
  Field<String>(fieldName: 'photoURL', defaultValue: (ctx) => ''),
  Field<num>(fieldName: 'level', defaultValue: (ctx) => 1),
  Field<num>(fieldName: 'currentHP', defaultValue: (ctx) => 10),
  Field<num>(fieldName: 'currentXP', defaultValue: (ctx) => 0),
  Field<List<Move>>(
    fieldName: 'moves',
    defaultValue: (ctx) => [],
    fromJSON: (moves, ctx) {
      print('moves: $moves');
      var mapped = (moves as Iterable).map<Move>((m) {
        print('m: $m');
        return Move.fromJSON(m);
      }).toList();
      return mapped;
    },
    toJSON: (moves, ctx) => moves.map((m) => m.toJSON()).toList(),
  ),
  Field<List<Note>>(
    fieldName: 'notes',
    defaultValue: (ctx) => [],
    fromJSON: (notes, ctx) =>
        (notes as List).map<Note>((n) => Note.fromJSON(n)).toList(),
    toJSON: (notes, ctx) => notes.map((n) => n.toJSON()).toList(),
  ),
  Field<List<DbSpell>>(
    fieldName: 'spells',
    defaultValue: (ctx) => [],
    fromJSON: (spells, ctx) =>
        (spells as List).map<DbSpell>((s) => DbSpell.fromJSON(s)).toList(),
    toJSON: (spells, ctx) => spells.map((s) => s.toJSON()).toList(),
  ),
  Field<List<InventoryItem>>(
    fieldName: 'inventory',
    defaultValue: (ctx) => [],
    fromJSON: (inventory, ctx) => (inventory as List)
        .map<InventoryItem>((s) => InventoryItem.fromJSON(s))
        .toList(),
    toJSON: (inventory, ctx) => inventory.map((i) => i.toJSON()).toList(),
  ),
  Field<Dice>(
    fieldName: 'hitDice',
    defaultValue: (ctx) => Dice.d6,
    fromJSON: (dice, ctx) => Dice.parse(dice),
    toJSON: (dice, ctx) => dice.toString(),
  ),
  Field<List<String>>(fieldName: 'looks', defaultValue: (ctx) => []),
  Field<Move>(
    fieldName: 'race',
    defaultValue: (ctx) => dungeonWorld.classes.first.raceMoves.first,
    fromJSON: (move, ctx) => Move.fromJSON(move),
    toJSON: (move, ctx) => move.toJSON(),
  ),
  Field<num>(fieldName: 'coins', defaultValue: (ctx) => 0),
]);

class Character extends FirebaseEntity {
  Fields _fields;

  @override
  Fields get fields => _fields ??= _charFields.copy();

  Character({
    Map<String, dynamic> data,
    DocumentReference ref,
  }) : super(ref: ref, data: data);

  // Class-Related
  set useDefaultMaxHP(bool value) =>
      fields.get<bool>('useDefaultMaxHP').set(value);
  set alignment(Alignment value) =>
      fields.get<Alignment>('alignment').set(value);
  PlayerClass get mainClass => fields.get<PlayerClass>('mainClass').value;
  set mainClass(PlayerClass value) =>
      fields.get<PlayerClass>('mainClass').set(value);
  Dice get damageDice => fields.get<Dice>('hitDice').value;
  set damageDice(Dice value) => fields.get<Dice>('hitDice').set(value);
  Alignment get alignment => fields.get<Alignment>('alignment').value;
  num get level => fields.get<num>('level').value;
  set level(num value) => fields.get<num>('level').set(value);
  num get _currentHP => fields.get<num>('currentHP').value;
  num get currentHP => min(_currentHP, maxHP);
  set currentHP(num value) => fields.get<num>('currentHP').set(value);
  num get currentXP => fields.get<num>('currentXP').value;
  set currentXP(num value) => fields.get<num>('currentXP').set(value);
  num get _maxHP => fields.get<num>('maxHP').value;
  set _maxHP(num value) => fields.get<num>('maxHP').set(value);
  num get maxHP => useDefaultMaxHP == true ? defaultMaxHP : _maxHP;

  set maxHP(value) {
    _maxHP = value;
    if (currentHP > _maxHP) currentHP = value;
  }

  // Stats
  num get str => fields.get<num>('str').value;
  set str(num value) => fields.get<num>('str').set(value);
  num get dex => fields.get<num>('dex').value;
  set dex(num value) => fields.get<num>('dex').set(value);
  num get con => fields.get<num>('con').value;
  set con(num value) => fields.get<num>('con').set(value);
  num get wis => fields.get<num>('wis').value;
  set wis(num value) => fields.get<num>('wis').set(value);
  num get int => fields.get<num>('int').value;
  set int(num value) => fields.get<num>('int').set(value);
  num get cha => fields.get<num>('cha').value;
  set cha(num value) => fields.get<num>('cha').set(value);
  num get armor => fields.get<num>('armor').value;
  set armor(num value) => fields.get<num>('armor').set(value);

  // Main Item Types
  List<Move> get moves => fields.get<List<Move>>('moves').value;
  set moves(List<Move> value) => fields.get<List<Move>>('moves').set(value);
  List<Note> get notes => fields.get<List<Note>>('notes').value;
  set notes(List<Note> value) => fields.get<List<Note>>('notes').set(value);
  List<DbSpell> get spells => fields.get<List<DbSpell>>('spells').value;
  set spells(List<DbSpell> value) =>
      fields.get<List<DbSpell>>('spells').set(value);
  List<InventoryItem> get inventory =>
      fields.get<List<InventoryItem>>('inventory').value;
  set inventory(List<InventoryItem> value) =>
      fields.get<List<InventoryItem>>('inventory').set(value);

  // Misc
  num get docVersion => fields.get<num>('docVersion').value;
  set docVersion(num value) => fields.get<num>('docVersion').set(value);

  // Bio
  String get displayName => fields.get<String>('displayName').value;
  set displayName(String value) => fields.get<String>('displayName').set(value);
  String get photoURL => fields.get<String>('photoURL').value;
  set photoURL(String value) => fields.get<String>('photoURL').set(value);
  List<String> get looks => fields.get<List<String>>('looks').value;
  set looks(List<String> value) => fields.get<List<String>>('looks').set(value);
  Move get race => fields.get<Move>('race').value;
  set race(Move value) => fields.get<Move>('race').set(value);
  num get coins => fields.get<num>('coins').value;
  set coins(num value) => fields.get<num>('coins').set(value);
  bool get useDefaultMaxHP => fields.get<bool>('useDefaultMaxHP').value;

  num get strMod => statModifier(str);
  num get dexMod => statModifier(dex);
  num get conMod => statModifier(con);
  num get wisMod => statModifier(wis);
  num get intMod => statModifier(int);
  num get chaMod => statModifier(cha);

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

  num get defaultMaxHP => (mainClass?.baseHP ?? 0) + conMod;

  @override
  Future<void> update({Map<String, dynamic> json, bool save = true}) async {
    // if (json == null || json.isEmpty == true) {
    //   return;
    // }
    // json = prepareJSONUpdate(json, useSetter: false);
    unawaited(super.update(json: json, save: save));
    dwStore.dispatch(CharacterActions.updateCharacter(this));
  }

  @override
  String toString() => '$displayName (Lv. $level ${mainClass?.name})';
}
