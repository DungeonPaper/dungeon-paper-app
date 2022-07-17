import 'dart:convert';
import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/spell_filters.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/dw_icons.dart';
import 'meta.dart';

class Spell extends dw.Spell implements WithMeta, WithIcon {
  Spell({
    required Meta meta,
    required String key,
    required String name,
    required String description,
    required String explanation,
    required String level,
    required List<dw.EntityReference> classKeys,
    required List<dw.Dice> dice,
    required List<dw.Tag> tags,
    this.prepared = false,
  })  : _meta = meta,
        super(
          meta: meta,
          key: key,
          name: name,
          description: description,
          explanation: explanation,
          level: level,
          classKeys: classKeys,
          dice: dice,
          tags: tags,
        );

  @override
  Meta get meta => _meta;
  final Meta _meta;
  final bool prepared;

  @override
  Spell copyWithInherited({
    Meta? meta,
    String? key,
    String? name,
    String? description,
    String? explanation,
    String? level,
    List<dw.EntityReference>? classKeys,
    List<dw.Dice>? dice,
    List<dw.Tag>? tags,
    bool? prepared,
  }) =>
      Spell(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
        explanation: explanation ?? this.explanation,
        level: level ?? this.level,
        classKeys: classKeys ?? this.classKeys,
        dice: dice ?? this.dice,
        tags: tags ?? this.tags,
        prepared: prepared ?? this.prepared,
      );

  factory Spell.fromRawJson(String str) => Spell.fromJson(json.decode(str));

  factory Spell.fromDwSpell(dw.Spell spell, {bool? prepared}) => Spell(
        meta: spell.meta != null ? Meta.fromJson(spell.meta) : Meta.empty(),
        key: spell.key,
        name: spell.name,
        description: spell.description,
        explanation: spell.explanation,
        level: spell.level,
        classKeys: spell.classKeys,
        dice: spell.dice,
        tags: spell.tags,
        prepared: prepared ?? false,
      );

  factory Spell.fromJson(Map<String, dynamic> json) =>
      Spell.fromDwSpell(dw.Spell.fromJson(json), prepared: json['prepared']);

  factory Spell.empty() => Spell(
        meta: Meta.empty(createdBy: user.username),
        classKeys: [],
        description: '',
        dice: [],
        explanation: '',
        level: '',
        key: uuid(),
        name: '',
        tags: [],
        prepared: false,
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '_meta': meta.toJson(),
        'prepared': prepared,
      };

  @override
  IconData get icon => DwIcons.book_cover;
  static IconData get genericIcon => DwIcons.book_cover;
  static int Function(Spell a, Spell b) sorter(SpellFilters filters) => (a, b) {
        final levelOrder = ['cantrip', 'rote', ...List.generate(9, (i) => '${i + 1}')];
        final level = levelOrder.indexOf(a.level).compareTo(levelOrder.indexOf(b.level));
        if (level != 0) {
          return level;
        }
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      };

  static User get user => Get.find<UserService>().current;

  @override
  String get displayName => name;

  @override
  String get storageKey => Meta.storageKeyFor(Spell);

  @override
  dw.EntityReference get reference => Meta.referenceFor(this);

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is Spell &&
          runtimeType == other.runtimeType &&
          meta == other.meta &&
          key == other.key &&
          name == other.name &&
          description == other.description &&
          explanation == other.explanation &&
          level == other.level &&
          classKeys == other.classKeys &&
          dice == other.dice &&
          tags == other.tags;

  @override
  int get hashCode =>
      Object.hashAll([meta, key, name, description, explanation, level, classKeys, dice, tags]);

  @override
  String get debugProperties =>
      'meta: $meta, key: $key, name: $name, description: $description, explanation: $explanation, level: $level, classKeys: $classKeys, dice: $dice, tags: $tags';

  @override
  String toString() => 'Spell($debugProperties)';
}
