import 'dart:convert';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

import 'meta.dart';

class Note with WithMeta, WithIcon {
  Note({
    required this.meta,
    required this.key,
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.favorite,
  });

  @override
  final Meta meta;
  @override
  final String key;
  final String title;
  final String description;
  final String category;
  final List<dw.Tag> tags;
  final bool favorite;

  String get localizedCategory => category.isEmpty ? S.current.noteNoCategory : category;

  @override
  Note copyWith({
    Meta? meta,
    String? key,
    String? title,
    String? description,
    String? category,
    List<dw.Tag>? tags,
    bool? favorite,
  }) =>
      Note(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        tags: tags ?? this.tags,
        favorite: favorite ?? this.favorite,
      );
  @override
  Note copyWithInherited({
    Meta? meta,
    String? key,
    String? title,
    String? description,
    String? category,
    List<dw.Tag>? tags,
    bool? favorite,
  }) =>
      copyWith(
        meta: meta,
        key: key,
        title: title,
        description: description,
        category: category,
        tags: tags,
        favorite: favorite,
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
        favorite: json['favorite'] ?? false,
      );

  factory Note.empty() => Note(
        description: '',
        favorite: false,
        key: uuid(),
        meta: Meta.empty(),
        tags: [],
        title: '',
        category: '',
      );

  @override
  Map<String, dynamic> toJson() => {
        '_meta': meta.toJson(),
        'key': key,
        'title': title,
        'category': category,
        'description': description,
        'tags': List<dynamic>.from(tags.map((x) => x.toJson())),
        'favorite': favorite,
      };

  @override
  IconData get icon => Icons.speaker_notes;
  static IconData get genericIcon => Icons.speaker_notes;

  @override
  String get displayName => title;

  @override
  String get storageKey => Meta.storageKeyFor(Note);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note &&
          runtimeType == other.runtimeType &&
          meta == other.meta &&
          key == other.key &&
          title == other.title &&
          description == other.description &&
          category == other.category &&
          tags == other.tags &&
          favorite == other.favorite;

  @override
  int get hashCode => Object.hashAll([meta, key, title, description, category, tags, favorite]);

  String get debugProperties =>
      'meta: $meta, key: $key, title: $title, description: $description, category: $category, tags: $tags, favorite: $favorite';

  @override
  String toString() => 'Note($debugProperties)';
}
