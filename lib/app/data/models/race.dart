import 'dart:convert';
import 'package:dungeon_paper/app/model_utils/model_icon.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
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
    required List<String> classKeys,
    required List<dw.Tag> tags,
    this.favorited = false,
  })  : _meta = meta,
        super(
          meta: meta,
          key: key,
          name: name,
          description: description,
          explanation: explanation,
          classKeys: classKeys,
          tags: tags,
        );

  @override
  Meta get meta => _meta;
  final Meta _meta;

  final bool favorited;

  @override
  Race copyWithInherited({
    Meta? meta,
    String? key,
    String? name,
    String? description,
    String? explanation,
    List<String>? classKeys,
    List<dw.Tag>? tags,
    bool? favorited,
  }) =>
      Race(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
        explanation: explanation ?? this.explanation,
        classKeys: classKeys ?? this.classKeys,
        tags: tags ?? this.tags,
        favorited: favorited ?? this.favorited,
      );

  factory Race.fromRawJson(String str) => Race.fromJson(json.decode(str));

  factory Race.fromDwRace(dw.Race race, {Meta? meta, bool favorited = false}) => Race(
        meta: race.meta != null ? Meta.fromJson(race.meta) : Meta.version(1),
        key: race.key,
        name: race.name,
        description: race.description,
        explanation: race.explanation,
        classKeys: race.classKeys,
        tags: race.tags,
        favorited: favorited,
      );

  factory Race.fromJson(Map<String, dynamic> json) => Race(
      meta: Meta.tryParse(json['_meta']),
      key: json['key'],
      name: json['name'],
      description: json['description'],
      explanation: json['explanation'],
      classKeys: List<String>.from(json['classKeys'].map((x) => x)),
      tags: List<dw.Tag>.from(json['tags'].map((x) => dw.Tag.fromJson(x))),
      favorited: json['favorited'] ?? false);

  factory Race.empty() => Race(
        classKeys: [],
        description: '',
        explanation: '',
        key: uuid(),
        meta: Meta.version(1),
        name: '',
        tags: [],
      );

  Move toMove() => Move(
      category: dw.MoveCategory.other,
      classKeys: classKeys,
      description: description,
      dice: [],
      explanation: explanation,
      key: key,
      meta: meta,
      name: name,
      tags: tags,
      favorited: favorited);

  @override
  IconData get icon => genericIcon;
  static IconData get genericIcon => DwIcons.riposte;

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '_meta': meta.toJson(),
        'favorited': favorited,
      };
}
