import 'dart:convert';

import 'meta.dart';
import 'tag.dart';

class Note {
  Note({
    required this.meta,
    required this.key,
    required this.title,
    required this.description,
    required this.tags,
  });

  final Meta meta;
  final String key;
  final String title;
  final String description;
  final List<Tag> tags;

  Note copyWith({
    Meta? meta,
    String? key,
    String? title,
    String? description,
    List<Tag>? tags,
  }) =>
      Note(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        title: title ?? this.title,
        description: description ?? this.description,
        tags: tags ?? this.tags,
      );

  factory Note.fromRawJson(String str) => Note.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        meta: Meta.fromJson(json["_meta"]),
        key: json["key"],
        title: json["title"],
        description: json["description"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_meta": meta.toJson(),
        "key": key,
        "title": title,
        "description": description,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };
}
