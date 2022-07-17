import 'dart:convert';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/race_filters.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

import 'meta.dart';
import 'move.dart';

class Race extends dw.Race implements WithMeta, WithIcon {
  Race({
    required Meta meta,
    required String key,
    required String name,
    required String description,
    required String explanation,
    required List<dw.EntityReference> classKeys,
    required List<dw.Tag> tags,
    required List<dw.Dice> dice,
    this.favorite = false,
  })  : _meta = meta,
        super(
          meta: meta,
          key: key,
          name: name,
          description: description,
          explanation: explanation,
          classKeys: classKeys,
          tags: tags,
          dice: dice,
        );

  @override
  Meta get meta => _meta;
  final Meta _meta;

  final bool favorite;

  @override
  Race copyWithInherited({
    Meta? meta,
    String? key,
    String? name,
    String? description,
    String? explanation,
    List<dw.EntityReference>? classKeys,
    List<dw.Tag>? tags,
    bool? favorite,
    List<dw.Dice>? dice,
  }) =>
      Race(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
        explanation: explanation ?? this.explanation,
        classKeys: classKeys ?? this.classKeys,
        tags: tags ?? this.tags,
        favorite: favorite ?? this.favorite,
        dice: dice ?? this.dice,
      );

  factory Race.fromRawJson(String str) => Race.fromJson(json.decode(str));

  factory Race.fromDwRace(dw.Race race, {Meta? meta, bool favorite = false}) => Race(
        meta: race.meta != null ? Meta.fromJson(race.meta) : Meta.empty(),
        key: race.key,
        name: race.name,
        description: race.description,
        explanation: race.explanation,
        classKeys: race.classKeys,
        tags: race.tags,
        favorite: favorite,
        dice: race.dice,
      );

  factory Race.fromJson(Map<String, dynamic> json) => Race(
        meta: Meta.tryParse(json['_meta']),
        key: json['key'],
        name: json['name'],
        description: json['description'],
        explanation: json['explanation'],
        classKeys: List<dw.EntityReference>.from(
            json['classKeys'].map((x) => dw.EntityReference.fromJson(x))),
        tags: List<dw.Tag>.from(json['tags'].map((x) => dw.Tag.fromJson(x))),
        favorite: json['favorite'] ?? false,
        dice: List<dw.Dice>.from(json['dice'].map((x) => dw.Dice.fromJson(x))),
      );

  factory Race.empty() => Race(
        classKeys: [],
        description: '',
        explanation: '',
        key: uuid(),
        meta: Meta.empty(),
        name: '',
        tags: [],
        dice: [],
      );

  Move toMove() => Move(
        category: dw.MoveCategory.other,
        classKeys: classKeys,
        description: description,
        explanation: explanation,
        key: key,
        meta: meta,
        name: name,
        tags: tags,
        dice: dice,
        favorite: favorite,
      );

  @override
  IconData get icon => genericIcon;
  static IconData get genericIcon => Icons.pets;

  static int Function(Race a, Race b) sorter(RaceFilters filters) => sort;

  static int sort(Race a, Race b) {
    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '_meta': meta.toJson(),
        'favorite': favorite,
      };

  @override
  String get displayName => name;

  @override
  String get storageKey => Meta.storageKeyFor(Race);

  @override
  dw.EntityReference get reference => Meta.referenceFor(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Race &&
          runtimeType == other.runtimeType &&
          meta == other.meta &&
          key == other.key &&
          name == other.name &&
          description == other.description &&
          explanation == other.explanation &&
          classKeys == other.classKeys &&
          tags == other.tags &&
          dice == other.dice;

  @override
  int get hashCode =>
      Object.hashAll([meta, key, name, description, explanation, classKeys, tags, dice]);

  String get debugProperties =>
      'meta: $meta, key: $key, name: $name, description: $description, explanation: $explanation, classKeys: $classKeys, tags: $tags, dice: $dice';

  @override
  String toString() => 'Race($debugProperties)';
}
