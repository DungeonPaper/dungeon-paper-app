import 'dart:convert';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

import 'meta.dart';

class Note implements WithMeta {
  Note({
    required this.meta,
    required this.key,
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.favorited,
  });

  @override
  final Meta meta;
  @override
  final String key;
  final String title;
  final String description;
  final String category;
  final List<dw.Tag> tags;
  final bool favorited;

  String get localizedCategory => category.isEmpty ? S.current.noteNoCategory : category;

  Note copyWith({
    Meta? meta,
    String? key,
    String? title,
    String? description,
    String? category,
    List<dw.Tag>? tags,
    bool? favorited,
  }) =>
      Note(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        tags: tags ?? this.tags,
        favorited: favorited ?? this.favorited,
      );

  factory Note.fromRawJson(String str) => Note.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        meta: Meta.tryParse(json['_meta']),
        key: json['key'],
        title: json['title'],
        description: json['description'],
        category: json['category'] ?? '',
        tags: List<dw.Tag>.from(json['tags'].map((x) => dw.Tag.fromJson(x))),
        favorited: json['favorited'] ?? false,
      );

  factory Note.empty() => Note(
        description: '',
        favorited: false,
        key: uuid(),
        meta: Meta.version(1),
        tags: [],
        title: '',
        category: '',
      );

  Map<String, dynamic> toJson() => {
        '_meta': meta.toJson(),
        'key': key,
        'title': title,
        'category': category,
        'description': description,
        'tags': List<dynamic>.from(tags.map((x) => x.toJson())),
        'favorited': favorited,
      };

  IconData get icon => Icons.speaker_notes;
  static IconData get genericIcon => Icons.speaker_notes;
}
