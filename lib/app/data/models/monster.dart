import 'dart:convert';

import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class Monster extends dw.Monster implements WithMeta {
  Monster({
    required Meta meta,
    required String key,
    required String name,
    required String description,
    required String instinct,
    required List<dw.Tag> tags,
    required List<String> moves,
  })  : _meta = meta,
        super(
          meta: meta,
          key: key,
          name: name,
          description: description,
          instinct: instinct,
          tags: tags,
          moves: moves,
        );

  @override
  Meta get meta => _meta;
  final Meta _meta;

  @override
  Monster copyWithInherited({
    Meta? meta,
    String? key,
    String? name,
    String? description,
    String? instinct,
    List<dw.Tag>? tags,
    List<String>? moves,
  }) =>
      Monster(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
        instinct: instinct ?? this.instinct,
        tags: tags ?? this.tags,
        moves: moves ?? this.moves,
      );

  factory Monster.fromRawJson(String str) => Monster.fromJson(json.decode(str));
  factory Monster.fromDwMonster(dw.Monster monster) =>
      Monster.fromJson(monster.toJson());

  factory Monster.fromJson(Map<String, dynamic> json) => Monster(
        meta: Meta.tryParse(json['_meta']),
        key: json['key'],
        name: json['name'],
        description: json['description'],
        instinct: json['instinct'],
        tags: List<dw.Tag>.from(json['tags'].map((x) => dw.Tag.fromJson(x))),
        moves: List<String>.from(json['moves'].map((x) => x)),
      );

  @override
  String get displayName => name;

  @override
  String get storageKey => Meta.storageKeyFor(Monster);

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is Monster &&
          runtimeType == other.runtimeType &&
          meta == other.meta &&
          key == other.key &&
          name == other.name &&
          description == other.description &&
          instinct == other.instinct &&
          tags == other.tags &&
          moves == other.moves;

  @override
  int get hashCode =>
      Object.hashAll([meta, key, name, description, instinct, tags, moves]);

  @override
  String get debugProperties =>
      'meta: $meta, key: $key, name: $name, description: $description, instinct: $instinct, tags: $tags, moves: $moves';

  @override
  String toString() => 'Monster($debugProperties)';
}
