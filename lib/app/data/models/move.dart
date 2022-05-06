import 'dart:convert';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/filters/move_filters.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
export 'package:dungeon_world_data/move.dart' show MoveCategory;

import '../../../core/dw_icons.dart';
import '../../../core/utils/uuid.dart';
import 'meta.dart';

class Move extends dw.Move implements WithMeta {
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
    this.favorited = false,
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
  final bool favorited;

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
    bool? favorited,
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
        favorited: favorited ?? this.favorited,
      );

  factory Move.fromRawJson(String str) => Move.fromJson(json.decode(str));

  factory Move.fromDwMove(dw.Move move, {Meta? meta, bool? favorited}) => Move(
        meta: meta ?? Meta.version(1),
        key: move.key,
        name: move.name,
        description: move.description,
        explanation: move.explanation,
        dice: move.dice,
        classKeys: move.classKeys,
        tags: move.tags,
        category: move.category,
        favorited: favorited ?? false,
      );

  factory Move.fromJson(Map<String, dynamic> json) => Move.fromDwMove(
        dw.Move.fromJson(json),
        meta: json['_meta'] != null ? Meta.fromJson(json['_meta']) : null,
        favorited: json['favorited'],
      );

  factory Move.empty() => Move(
        key: uuid(),
        category: dw.MoveCategory.other,
        classKeys: [],
        description: '',
        dice: [],
        explanation: '',
        meta: Meta.version(1),
        name: '',
        tags: [],
        favorited: false,
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '_meta': meta.toJson(),
        'favorited': favorited,
      };

  @override
  String toString() => 'Move(key: $key, name: $name)';

  DwIconData get icon => DwIcons.riposte;
  static DwIconData get genericIcon => DwIcons.riposte;
  static int Function(Move a, Move b) sorter(MoveFilters filters) => (a, b) {
        final cat = a.category.index.compareTo(b.category.index);
        if (cat != 0) {
          return cat;
        }
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      };
}
