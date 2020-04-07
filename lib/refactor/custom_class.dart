import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character_utils.dart';
import 'package:dungeon_paper/refactor/firebase_entity/firebase_entity.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/gear_choice.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/spell.dart';

// Ordered by whichever data needs to come earliest for the rest to be able to calculate
Fields _clsFields = Fields([
  Field<String>(
    fieldName: 'name',
    defaultValue: (ctx) => '',
  ),
  Field<String>(
    fieldName: 'description',
    defaultValue: (ctx) => '',
  ),
  Field<num>(
    fieldName: 'load',
    defaultValue: (ctx) => 0,
  ),
  Field<num>(
    fieldName: 'baseHP',
    defaultValue: (ctx) => 0,
  ),
  Field<Dice>(
    fieldName: 'damage',
    defaultValue: (ctx) => Dice.d6,
  ),
  Field<Map<String, List<String>>>(
    fieldName: 'names',
    defaultValue: (ctx) => {},
  ),
  Field<List<String>>(
    fieldName: 'bonds',
    defaultValue: (ctx) => [],
  ),
  Field<List<List<String>>>(
    fieldName: 'looks',
    defaultValue: (ctx) => [],
  ),
  Field<Map<String, Alignment>>(
    fieldName: 'alignments',
    defaultValue: (ctx) => {},
  ),
  Field<List<Move>>(
    fieldName: 'raceMoves',
    defaultValue: (ctx) => [],
  ),
  Field<List<Move>>(
    fieldName: 'startingMoves',
    defaultValue: (ctx) => [],
  ),
  Field<List<Move>>(
    fieldName: 'advancedMoves1',
    defaultValue: (ctx) => [],
  ),
  Field<List<Move>>(
    fieldName: 'advancedMoves2',
    defaultValue: (ctx) => [],
  ),
  Field<List<Spell>>(
    fieldName: 'spells',
    defaultValue: (ctx) => [],
  ),
  Field<List<GearChoice>>(
    fieldName: 'gearChoices',
    defaultValue: (ctx) => [],
  ),
]);

class CustomClass extends FirebaseEntity {
  Fields _fields;

  @override
  Fields get fields => _fields ??= _clsFields.copy();

  CustomClass({
    Map<String, dynamic> data,
    DocumentReference ref,
  }) : super(ref: ref, data: data);

  Field<String> get key => fields.get('key').get;
  set key(value) => fields.get('key').set(value);
  Field<String> get name => fields.get('name').get;
  set name(value) => fields.get('name').set(value);
  Field<String> get description => fields.get('description').get;
  set description(value) => fields.get('description').set(value);
  Field<num> get load => fields.get('load').get;
  set load(value) => fields.get('load').set(value);
  Field<num> get baseHP => fields.get('baseHP').get;
  set baseHP(value) => fields.get('baseHP').set(value);
  Field<Dice> get damage => fields.get('damage').get;
  set damage(value) => fields.get('damage').set(value);
  Field<Map<String, List<String>>> get names => fields.get('names').get;
  set names(value) => fields.get('names').set(value);
  Field<List<String>> get bonds => fields.get('bonds').get;
  set bonds(value) => fields.get('bonds').set(value);
  Field<List<List<String>>> get looks => fields.get('looks').get;
  set looks(value) => fields.get('looks').set(value);
  Field<Map<String, Alignment>> get alignments => fields.get('alignments').get;
  set alignments(value) => fields.get('alignments').set(value);
  Field<List<Move>> get raceMoves => fields.get('raceMoves').get;
  set raceMoves(value) => fields.get('raceMoves').set(value);
  Field<List<Move>> get startingMoves => fields.get('startingMoves').get;
  set startingMoves(value) => fields.get('startingMoves').set(value);
  Field<List<Move>> get advancedMoves1 => fields.get('advancedMoves1').get;
  set advancedMoves1(value) => fields.get('advancedMoves1').set(value);
  Field<List<Move>> get advancedMoves2 => fields.get('advancedMoves2').get;
  set advancedMoves2(value) => fields.get('advancedMoves2').set(value);
  Field<List<Spell>> get spells => fields.get('spells').get;
  set spells(value) => fields.get('spells').set(value);
  Field<List<GearChoice>> get gearChoices => fields.get('gearChoices').get;
  set gearChoices(value) => fields.get('gearChoices').set(value);

  @override
  String toString() => 'Custom Class: $name ($key)';
}
