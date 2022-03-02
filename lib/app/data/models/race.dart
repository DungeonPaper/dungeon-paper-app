import 'dart:convert';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

import 'meta.dart';

class Race extends dw.Race {
  Race({
    required Meta meta,
    required String key,
    required String name,
    required String description,
    required String explanation,
    required List<String> classKeys,
    required List<dw.Tag> tags,
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

  Race copyWithInherited({
    Meta? meta,
    String? key,
    String? name,
    String? description,
    String? explanation,
    List<String>? classKeys,
    List<dw.Tag>? tags,
  }) =>
      Race(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
        explanation: explanation ?? this.explanation,
        classKeys: classKeys ?? this.classKeys,
        tags: tags ?? this.tags,
      );

  factory Race.fromRawJson(String str) => Race.fromJson(json.decode(str));

  factory Race.fromDwRace(dw.Race race, {Meta? meta}) => Race(
        meta: race.meta != null ? Meta.fromJson(race.meta) : Meta.version(1),
        key: race.key,
        name: race.name,
        description: race.description,
        explanation: race.explanation,
        classKeys: race.classKeys,
        tags: race.tags,
      );

  factory Race.fromJson(Map<String, dynamic> json) => Race(
        meta: Meta.fromJson(json['_meta']),
        key: json['key'],
        name: json['name'],
        description: json['description'],
        explanation: json['explanation'],
        classKeys: List<String>.from(json['classKeys'].map((x) => x)),
        tags: List<dw.Tag>.from(json['tags'].map((x) => dw.Tag.fromJson(x))),
      );

  factory Race.empty() => Race(
        classKeys: [],
        description: '',
        explanation: '',
        key: uuid(),
        meta: Meta.version(1),
        name: '',
        tags: [],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '_meta': meta.toJson(),
      };
}
