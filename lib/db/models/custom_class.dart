import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/helpers/character_utils.dart';
import 'package:dungeon_paper/src/redux/custom_classes/custom_classes_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/gear_choice.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/spell.dart';

import 'firebase_entity/fields/fields.dart';
import 'firebase_entity/firebase_entity.dart';

// Ordered by whichever data needs to come earliest for the rest to be able to calculate
FieldsContext _clsFields = FieldsContext([
  StringField(fieldName: 'name'),
  StringField(fieldName: 'description'),
  IntField(fieldName: 'load'),
  IntField(fieldName: 'baseHP'),
  DiceField(fieldName: 'damage', defaultValue: (ctx) => Dice.d6),
  NamesMapField(fieldName: 'names'),
  BondsListField(fieldName: 'bonds'),
  LooksOptionsListField(fieldName: 'looks'),
  AlignmentsMapField(fieldName: 'alignments'),
  MoveListField(fieldName: 'raceMoves'),
  MoveListField(fieldName: 'startingMoves'),
  MoveListField(fieldName: 'advancedMoves1'),
  MoveListField(fieldName: 'advancedMoves2'),
  SpellListField(fieldName: 'spells'),
  GearChoiceListField(fieldName: 'gearChoices'),
]);

class CustomClass extends FirebaseEntity {
  FieldsContext _fields;

  @override
  FieldsContext get fields => _fields ??= _clsFields.copy();

  CustomClass({
    Map<String, dynamic> data,
    DocumentReference ref,
    bool autoLoad,
  }) : super(ref: ref, data: data, autoLoad: autoLoad);

  String get key => fields.get('key').get;
  set key(value) => fields.get('key').set(value);
  String get name => fields.get('name').get;
  set name(value) => fields.get('name').set(value);
  String get description => fields.get('description').get;
  set description(value) => fields.get('description').set(value);
  num get load => fields.get('load').get;
  set load(value) => fields.get('load').set(value);
  num get baseHP => fields.get('baseHP').get;
  set baseHP(value) => fields.get('baseHP').set(value);
  Dice get damage => fields.get('damage').get;
  set damage(value) => fields.get('damage').set(value);
  Map<String, List<String>> get names => fields.get('names').get;
  set names(value) => fields.get('names').set(value);
  List<String> get bonds => fields.get('bonds').get;
  set bonds(value) => fields.get('bonds').set(value);
  List<List<String>> get looks => fields.get('looks').get;
  set looks(value) => fields.get('looks').set(value);
  Map<String, AlignmentName> get alignments => fields.get('alignments').get;
  set alignments(value) => fields.get('alignments').set(value);
  List<Move> get raceMoves => fields.get('raceMoves').get;
  set raceMoves(value) => fields.get('raceMoves').set(value);
  List<Move> get startingMoves => fields.get('startingMoves').get;
  set startingMoves(value) => fields.get('startingMoves').set(value);
  List<Move> get advancedMoves1 => fields.get('advancedMoves1').get;
  set advancedMoves1(value) => fields.get('advancedMoves1').set(value);
  List<Move> get advancedMoves2 => fields.get('advancedMoves2').get;
  set advancedMoves2(value) => fields.get('advancedMoves2').set(value);
  List<Spell> get spells => fields.get('spells').get;
  set spells(value) => fields.get('spells').set(value);
  List<GearChoice> get gearChoices => fields.get('gearChoices').get;
  set gearChoices(value) => fields.get('gearChoices').set(value);

  @override
  void finalizeUpdate(Map<String, dynamic> json, {bool save = true}) {
    if (save) {
      dwStore.dispatch(UpsertCustomClass(this));
    }
    super.finalizeUpdate(json, save: save);
  }

  @override
  String toString() => 'Custom Class: $name ($key)';
}
