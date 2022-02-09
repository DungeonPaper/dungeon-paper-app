import 'dart:convert';

import 'meta.dart';
import 'tag.dart';

class Spell {
  Spell({
    required this.meta,
    required this.key,
    required this.name,
    required this.description,
    required this.explanation,
    required this.classKeys,
    required this.tags,
    this.prepared = false,
  });

  final Meta meta;
  final String key;
  final String name;
  final String description;
  final String explanation;
  final List<String> classKeys;
  final List<Tag> tags;
  final bool prepared;

  Spell copyWith({
    Meta? meta,
    String? key,
    String? name,
    String? description,
    String? explanation,
    List<String>? classKeys,
    List<Tag>? tags,
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

  String toRawJson() => json.encode(toJson());

  factory Spell.fromJson(Map<String, dynamic> json) => Spell(
        meta: Meta.fromJson(json["_meta"]),
        key: json["key"],
        name: json["name"],
        description: json["description"],
        explanation: json["explanation"],
        classKeys: List<String>.from(json["classKeys"].map((x) => x)),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        prepared: json["prepared"],
      );

  Map<String, dynamic> toJson() => {
        "_meta": meta.toJson(),
        "key": key,
        "name": name,
        "description": description,
        "explanation": explanation,
        "classKeys": List<dynamic>.from(classKeys.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "prepared": prepared,
      };
}
