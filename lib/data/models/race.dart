import 'dart:convert';

import 'meta.dart';
import 'tag.dart';

class Race {
  Race({
    required this.meta,
    required this.key,
    required this.name,
    required this.description,
    required this.explanation,
    required this.classKeys,
    required this.tags,
  });

  final Meta meta;
  final String key;
  final String name;
  final String description;
  final String explanation;
  final List<String> classKeys;
  final List<Tag> tags;

  Race copyWith({
    Meta? meta,
    String? key,
    String? name,
    String? description,
    String? explanation,
    List<String>? classKeys,
    List<Tag>? tags,
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

  String toRawJson() => json.encode(toJson());

  factory Race.fromJson(Map<String, dynamic> json) => Race(
        meta: Meta.fromJson(json["_meta"]),
        key: json["key"],
        name: json["name"],
        description: json["description"],
        explanation: json["explanation"],
        classKeys: List<String>.from(json["classKeys"].map((x) => x)),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_meta": meta.toJson(),
        "key": key,
        "name": name,
        "description": description,
        "explanation": explanation,
        "classKeys": List<dynamic>.from(classKeys.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };
}
