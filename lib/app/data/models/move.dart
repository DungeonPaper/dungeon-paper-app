import 'dart:convert';

import 'dice.dart';
import 'meta.dart';
import 'tag.dart';

enum MoveCategory {
  starting,
  basic,
  advanced1,
  advanced2,
  other,
}

class Move {
  Move({
    required this.meta,
    required this.key,
    required this.name,
    required this.description,
    required this.explanation,
    required this.dice,
    required this.classKeys,
    required this.tags,
    required this.category,
  });

  final SharedMeta meta;
  final String key;
  final String name;
  final String description;
  final String explanation;
  final List<Dice> dice;
  final List<String> classKeys;
  final List<Tag> tags;
  final MoveCategory category;

  Move copyWith({
    SharedMeta? meta,
    String? key,
    String? name,
    String? description,
    String? explanation,
    List<Dice>? dice,
    List<String>? classKeys,
    List<Tag>? tags,
    MoveCategory? category,
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

  String toRawJson() => json.encode(toJson());

  factory Move.fromJson(Map<String, dynamic> json) => Move(
        meta: SharedMeta.fromJson(json["_meta"]),
        key: json["key"],
        name: json["name"],
        description: json["description"],
        explanation: json["explanation"],
        dice: List<Dice>.from(json["dice"].map((x) => x.toJson())),
        classKeys: List<String>.from(json["classKeys"].map((x) => x)),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        category: MoveCategory.values
            .firstWhere((element) => element.name == json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "_meta": meta.toJson(),
        "key": key,
        "name": name,
        "description": description,
        "explanation": explanation,
        "dice": List<String>.from(dice.map((x) => x.toJson())),
        "classKeys": List<dynamic>.from(classKeys.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "category": category.name,
      };
}
