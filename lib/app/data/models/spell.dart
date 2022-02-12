import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

import 'meta.dart';

class Spell extends dw.Spell {
  Spell({
    required SharedMeta meta,
    required String key,
    required String name,
    required String description,
    required String explanation,
    required List<String> classKeys,
    required List<dw.Tag> tags,
    this.prepared = false,
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
  SharedMeta get meta => _meta;
  final SharedMeta _meta;
  final bool prepared;

  Spell copyWithInherited({
    SharedMeta? meta,
    String? key,
    String? name,
    String? description,
    String? explanation,
    List<String>? classKeys,
    List<dw.Tag>? tags,
    bool? prepared,
  }) =>
      Spell(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
        explanation: explanation ?? this.explanation,
        classKeys: classKeys ?? this.classKeys,
        tags: tags ?? this.tags,
        prepared: prepared ?? this.prepared,
      );

  factory Spell.fromRawJson(String str) => Spell.fromJson(json.decode(str));

  factory Spell.fromDwSpell(dw.Spell spell) => Spell(
        meta: spell.meta != null
            ? SharedMeta.fromJson(spell.meta)
            : SharedMeta.version(1),
        key: spell.key,
        name: spell.name,
        description: spell.description,
        explanation: spell.explanation,
        classKeys: spell.classKeys,
        tags: spell.tags,
        prepared: false,
      );

  factory Spell.fromJson(Map<String, dynamic> json) =>
      Spell.fromDwSpell(dw.Spell.fromJson(json));

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        "_meta": meta.toJson(),
      };
}
