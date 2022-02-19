import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

import 'meta.dart';

class Move extends dw.Move {
  Move({
    required Meta meta,
    required String key,
    required String name,
    required String description,
    required String explanation,
    required List<dw.Dice> dice,
    required List<String> classKeys,
    required List<dw.Tag> tags,
    required dw.MoveCategory category,
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

  Move copyWithInherited({
    Meta? meta,
    String? key,
    String? name,
    String? description,
    String? explanation,
    List<dw.Dice>? dice,
    List<String>? classKeys,
    List<dw.Tag>? tags,
    dw.MoveCategory? category,
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
      );

  factory Move.fromRawJson(String str) => Move.fromJson(json.decode(str));

  factory Move.fromDwMove(dw.Move move, {Meta? meta}) => Move(
        meta: meta ?? Meta.version(1),
        key: move.key,
        name: move.name,
        description: move.description,
        explanation: move.explanation,
        dice: move.dice,
        classKeys: move.classKeys,
        tags: move.tags,
        category: move.category,
      );

  factory Move.fromJson(Map<String, dynamic> json) => Move.fromDwMove(dw.Move.fromJson(json));

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        "_meta": meta.toJson(),
      };
}
