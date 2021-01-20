import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/db/models/converters/default_uuid.dart';
import 'package:dungeon_paper/db/models/converters/dice_converter.dart';
import 'package:dungeon_paper/db/models/converters/document_reference_converter.dart';
import 'package:dungeon_paper/db/models/converters/dw_alignment_converter.dart';
import 'package:dungeon_paper/db/models/converters/dw_gear_choice_converter.dart';
import 'package:dungeon_paper/db/models/converters/dw_move_converter.dart';
import 'package:dungeon_paper/db/models/converters/dw_spell_converter.dart';
import 'package:dungeon_paper/src/controllers/characters_controller.dart';
import 'package:dungeon_paper/src/controllers/custom_classes_controller.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/alignment.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/gear_choice.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:dungeon_world_data/spell.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_class.freezed.dart';
part 'custom_class.g.dart';

@freezed
abstract class CustomClass
    with FirebaseMixin, KeyMixin
    implements _$CustomClass {
  const CustomClass._();

  @With(FirebaseMixin)
  @With(KeyMixin)
  const factory CustomClass({
    @DefaultUuid() String key,
    @DocumentReferenceConverter() DocumentReference ref,
    String name,
    String description,
    num load,
    num baseHP,
    @DiceConverter() Dice damage,
    Map<String, List<String>> names,
    List<String> bonds,
    Map<String, List<String>> looks,
    @DWAlignmentConverter() Map<String, Alignment> alignments,
    @DWMoveConverter() List<Move> raceMoves,
    @DWMoveConverter() List<Move> startingMoves,
    @DWMoveConverter() List<Move> advancedMoves1,
    @DWMoveConverter() List<Move> advancedMoves2,
    @DWSpellConverter() List<Spell> spells,
    @DWGearChoiceConverter() List<GearChoice> gearChoices,
  }) = _CustomClass;

  factory CustomClass.fromJson(json, {DocumentReference ref}) =>
      _$CustomClassFromJson(json).copyWith(ref: ref);

  static CustomClass fromPlayerClass(
    PlayerClass playerClass, {
    DocumentReference ref,
    bool retainKey = false,
  }) =>
      CustomClass.fromJson(
              _copyPlayerClsData(playerClass, retainKey: retainKey))
          .copyWith(ref: ref);

  static Map<String, dynamic> _copyPlayerClsData(
    PlayerClass playerClass, {
    bool retainKey = false,
  }) {
    final json =
        playerClass.toJSON().map((k, v) => MapEntry(snakeToCamel(k), v));
    json['looks'] = Map<String, dynamic>.from(
      ((json['looks'] ?? []) as List<List<String>>).asMap().map(
            (k, v) => MapEntry(k.toString(), v),
          ),
    );
    json['baseHP'] = json['baseHp'];
    json.remove('baseHp');
    if (!retainKey) {
      json.remove('key');
    }
    return Map<String, dynamic>.from(json);
  }

  PlayerClass toPlayerClass() {
    final data = Map<String, dynamic>.from(
      toJson().map((k, v) => MapEntry(camelToSnake(k), v)),
    );
    data['looks'] = looks.values.toList();
    return PlayerClass.fromJSON(data);
  }

  @override
  Future<DocumentReference> create() async {
    customClassesController.upsert(this);
    return super.create();
  }

  @override
  Future<DocumentReference> update({Iterable<String> keys}) async {
    customClassesController.upsert(this);
    final ref = super.update(keys: keys);
    await _updateChars();
    return ref;
  }

  @override
  Future<void> delete() async {
    customClassesController.remove(this);
    return super.delete();
  }

  Future<void> _updateChars() async {
    final futures = <Future>[];
    for (final char in characterController.all.values) {
      if (char.playerClasses.any((el) => el.key == key)) {
        final _updated = char.playerClasses
            .map((el) => el.key == key ? toPlayerClass() : el)
            .toList();
        futures.add(
          char.copyWith(playerClasses: _updated).update(
            keys: ['playerClasses'],
          ),
        );
      }
    }

    return Future.wait(futures);
  }
}
