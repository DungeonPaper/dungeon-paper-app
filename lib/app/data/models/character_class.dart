import 'dart:convert';

import 'package:dungeon_paper/app/modules/LibraryList/views/filters/character_class_filters.dart';
import 'package:dungeon_paper/core/utils/icon_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:flutter/material.dart';

import 'alignment.dart';
import 'gear_choice.dart';
import 'meta.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class CharacterClass extends dw.CharacterClass with WithIcon implements WithMeta {
  get isApp => true;

  CharacterClass({
    required Meta meta,
    required String name,
    required String key,
    required String description,
    required dw.Dice damageDice,
    required int load,
    required int hp,
    required AlignmentValues alignments,
    required List<String> bonds,
    required List<String> flags,
    required List<GearChoice> gearChoices,
    required bool isSpellcaster,
  })  : _meta = meta,
        _alignments = alignments,
        _gearChoices = gearChoices,
        super(
          meta: meta,
          name: name,
          key: key,
          description: description,
          damageDice: damageDice,
          load: load,
          hp: hp,
          alignments: alignments,
          bonds: bonds,
          flags: flags,
          gearChoices: gearChoices,
          isSpellcaster: isSpellcaster,
        );

  @override
  Meta get meta => _meta;
  final Meta _meta;

  @override
  AlignmentValues get alignments => _alignments;
  final AlignmentValues _alignments;

  @override
  List<GearChoice> get gearChoices => _gearChoices;
  final List<GearChoice> _gearChoices;

  @override
  CharacterClass copyWithInherited({
    Meta? meta,
    String? name,
    String? key,
    String? description,
    dw.Dice? damageDice,
    int? load,
    int? hp,
    AlignmentValues? alignments,
    List<String>? bonds,
    List<String>? flags,
    List<GearChoice>? gearChoices,
    bool? isSpellcaster,
  }) =>
      CharacterClass(
        meta: meta ?? this.meta,
        name: name ?? this.name,
        key: key ?? this.key,
        description: description ?? this.description,
        damageDice: damageDice ?? this.damageDice,
        load: load ?? this.load,
        hp: hp ?? this.hp,
        alignments: alignments ?? this.alignments,
        bonds: bonds ?? this.bonds,
        flags: flags ?? this.flags,
        gearChoices: gearChoices ?? this.gearChoices,
        isSpellcaster: isSpellcaster ?? this.isSpellcaster,
      );

  factory CharacterClass.fromRawJson(String str) => CharacterClass.fromJson(json.decode(str));

  factory CharacterClass.empty() => CharacterClass(
        meta: Meta.empty(),
        key: uuid(),
        name: '',
        bonds: [],
        flags: [],
        damageDice: dw.Dice.d6,
        description: '',
        gearChoices: [],
        load: 0,
        hp: 20,
        alignments: AlignmentValues.empty(),
        isSpellcaster: false,
      );

  factory CharacterClass.fromDwCharacterClass(dw.CharacterClass cls) => CharacterClass(
        meta: Meta.tryParse(cls.meta),
        name: cls.name,
        key: cls.key,
        description: cls.description,
        damageDice: cls.damageDice,
        load: cls.load,
        hp: cls.hp,
        alignments: AlignmentValues.fromDwAlignmentValues(cls.alignments),
        bonds: cls.bonds,
        flags: cls.flags,
        gearChoices: cls.gearChoices.map((c) => GearChoice.fromDwGearChoice(c)).toList(),
        isSpellcaster: cls.isSpellcaster,
      );

  factory CharacterClass.fromJson(Map<String, dynamic> json) =>
      CharacterClass.fromDwCharacterClass(dw.CharacterClass.fromJson(json));

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '_meta': meta.toJson(),
      };

  @override
  IconData get icon => genericIcon;
  static IconData get genericIcon => Icons.person_outline;

  static int Function(CharacterClass a, CharacterClass b) sorter(CharacterClassFilters filters) =>
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase());

  @override
  String get displayName => name;

  @override
  String get storageKey => Meta.storageKeyFor(CharacterClass);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterClass &&
          runtimeType == other.runtimeType &&
          meta == other.meta &&
          name == other.name &&
          key == other.key &&
          description == other.description &&
          damageDice == other.damageDice &&
          load == other.load &&
          hp == other.hp &&
          alignments == other.alignments &&
          bonds == other.bonds &&
          flags == other.flags &&
          gearChoices == other.gearChoices &&
          isSpellcaster == other.isSpellcaster;

  @override
  int get hashCode => Object.hashAll(
      [meta, name, key, description, damageDice, load, hp, alignments, bonds, flags, gearChoices]);

  @override
  String get debugProperties =>
      'meta: $meta, name: $name, key: $key, description: $description, damageDice: $damageDice, load: $load, hp: $hp, alignments: $alignments, bonds: $bonds, flags: $flags, gearChoices: $gearChoices';

  @override
  String toString() => 'CharacterClass($debugProperties)';
}
