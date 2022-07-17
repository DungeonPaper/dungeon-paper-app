import 'dart:convert';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/move_filters.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
export 'package:dungeon_world_data/move.dart' show MoveCategory;

import '../../../core/dw_icons.dart';
import '../../../core/utils/uuid.dart';
import 'meta.dart';

class Move extends dw.Move implements WithMeta, WithIcon {
  Move({
    required Meta meta,
    required String key,
    required String name,
    required String description,
    required String explanation,
    required List<dw.Dice> dice,
    required List<dw.EntityReference> classKeys,
    required List<dw.Tag> tags,
    required dw.MoveCategory category,
    this.favorite = false,
  })  : _meta = meta,
        super(
          meta: meta,
          key: key,
          name: name,
          description: description,
          explanation: explanation,
          dice: dice,
          classKeys: classKeys,
          tags: tags,
          category: category,
        );

  @override
  Meta get meta => _meta;
  final Meta _meta;
  final bool favorite;

  @override
  Move copyWithInherited({
    Meta? meta,
    String? key,
    String? name,
    String? description,
    String? explanation,
    List<dw.Dice>? dice,
    List<dw.EntityReference>? classKeys,
    List<dw.Tag>? tags,
    dw.MoveCategory? category,
    bool? favorite,
  }) =>
      Move(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
        explanation: explanation ?? this.explanation,
        dice: dice ?? this.dice,
        classKeys: classKeys ?? this.classKeys,
        tags: tags ?? this.tags,
        category: category ?? this.category,
        favorite: favorite ?? this.favorite,
      );

  factory Move.fromRawJson(String str) => Move.fromJson(json.decode(str));

  factory Move.fromDwMove(dw.Move move, {Meta? meta, bool? favorite}) => Move(
        meta: meta ?? Meta.empty(),
        key: move.key,
        name: move.name,
        description: move.description,
        explanation: move.explanation,
        dice: move.dice,
        classKeys: move.classKeys,
        tags: move.tags,
        category: move.category,
        favorite: favorite ?? false,
      );

  factory Move.fromJson(Map<String, dynamic> json) => Move.fromDwMove(
        dw.Move.fromJson(json),
        meta: json['_meta'] != null ? Meta.fromJson(json['_meta']) : null,
        favorite: json['favorite'],
      );

  factory Move.empty() => Move(
        key: uuid(),
        category: dw.MoveCategory.other,
        classKeys: [],
        description: '',
        dice: [],
        explanation: '',
        meta: Meta.empty(),
        name: '',
        tags: [],
        favorite: false,
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '_meta': meta.toJson(),
        'favorite': favorite,
      };

  @override
  IconData get icon => genericIcon;
  static IconData get genericIcon => DwIcons.riposte;

  static int Function(Move a, Move b) sorter(MoveFilters filters) => sort;

  static int sort(Move a, Move b) {
    final cat = a.category.index.compareTo(b.category.index);
    if (cat != 0) {
      return cat;
    }
    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  }

  @override
  String get displayName => name;

  @override
  String get storageKey => Meta.storageKeyFor(Move);

  @override
  dw.EntityReference get reference => Meta.referenceFor(this);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Move &&
          runtimeType == other.runtimeType &&
          meta == other.meta &&
          key == other.key &&
          name == other.name &&
          description == other.description &&
          explanation == other.explanation &&
          dice == other.dice &&
          classKeys == other.classKeys &&
          tags == other.tags &&
          category == other.category;

  @override
  int get hashCode =>
      Object.hashAll([meta, key, name, description, explanation, dice, classKeys, tags, category]);

  @override
  String get debugProperties =>
      'meta: $meta, name: $name, description: $description, explanation: $explanation, dice: $dice, classKeys: $classKeys, tags: $tags, category: $category';

  @override
  String toString() => 'Move($debugProperties)';
}
