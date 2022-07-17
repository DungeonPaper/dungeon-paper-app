import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

import 'meta.dart';

class AlignmentValue extends dw.Alignment implements WithMeta, WithIcon {
  AlignmentValue({
    required this.meta,
    required super.description,
    required super.type,
  });

  @override
  final Meta meta;

  static final allKeys = <String>['good', 'lawful', 'neutral', 'chaotic', 'evil'];

  factory AlignmentValue.fromRawJson(String str) => AlignmentValue.fromJson(json.decode(str));

  factory AlignmentValue.fromDwAlignmentValue(dw.Alignment original) => AlignmentValue(
      meta: Meta.empty(createdBy: '__repo__'),
      type: original.type,
      description: original.description);

  factory AlignmentValue.fromJson(Map<String, dynamic> json) => AlignmentValue(
        meta: Meta.tryParse(json['_meta']),
        type: dw.AlignmentType.values.firstWhere((element) => element.name == json['type']),
        description: json['description'],
      );

  static final iconMap = <String, IconData>{
    'good': Icons.mood,
    'lawful': Icons.sentiment_satisfied,
    'neutral': Icons.sentiment_neutral,
    'chaotic': Icons.sentiment_dissatisfied,
    'evil': Icons.mood_bad,
  };

  @override
  IconData get icon => iconOf(type);
  static IconData iconOf(dw.AlignmentType key) => iconMap[key.name]!;

  factory AlignmentValue.empty({
    dw.AlignmentType? type,
  }) =>
      AlignmentValue(
        meta: Meta.empty(),
        description: '',
        type: type ?? dw.AlignmentType.good,
      );

  @override
  AlignmentValue copyWith({
    Meta? meta,
    dw.AlignmentType? type,
    String? description,
  }) =>
      AlignmentValue(
        meta: meta ?? this.meta,
        type: type ?? this.type,
        description: description ?? this.description,
      );

  @override
  AlignmentValue copyWithInherited({
    Meta? meta,
    dw.AlignmentType? type,
    String? description,
    String? key,
  }) =>
      copyWith(
        meta: meta,
        type: type,
        description: description,
      );

  @override
  Map<String, dynamic> toJson() => {
        '_meta': meta.toJson(),
        'type': type.name,
        ...super.toJson(),
      };

  @override
  String get displayName => description;

  @override
  String get storageKey => throw TypeError();

  @override
  dw.EntityReference get reference => Meta.referenceFor(this);
}

class AlignmentValues extends dw.AlignmentValues {
  AlignmentValues({
    required this.meta,
    required String good,
    required String evil,
    required String lawful,
    required String neutral,
    required String chaotic,
  }) : super(
          good: good,
          evil: evil,
          lawful: lawful,
          neutral: neutral,
          chaotic: chaotic,
        );

  final Meta meta;

  String byType(dw.AlignmentType type) {
    final map = {
      dw.AlignmentType.good: good,
      dw.AlignmentType.evil: evil,
      dw.AlignmentType.lawful: lawful,
      dw.AlignmentType.neutral: neutral,
      dw.AlignmentType.chaotic: chaotic,
    };
    if (map[type] == null) {
      throw TypeError();
    }
    return map[type]!;
  }

  factory AlignmentValues.empty() => AlignmentValues(
        meta: Meta.empty(),
        good: '',
        evil: '',
        lawful: '',
        neutral: '',
        chaotic: '',
      );

  factory AlignmentValues.fromRawJson(String str) => AlignmentValues.fromJson(json.decode(str));

  factory AlignmentValues.fromJson(Map<String, dynamic> json) => AlignmentValues(
        meta: Meta.tryParse(json['_meta']),
        good: json['good'],
        evil: json['evil'],
        lawful: json['lawful'],
        neutral: json['neutral'],
        chaotic: json['chaotic'],
      );

  AlignmentValues copyWithInherited({
    Meta? meta,
    String? good,
    String? evil,
    String? lawful,
    String? neutral,
    String? chaotic,
  }) =>
      AlignmentValues(
        meta: meta ?? this.meta,
        good: good ?? this.good,
        evil: evil ?? this.evil,
        lawful: lawful ?? this.lawful,
        neutral: neutral ?? this.neutral,
        chaotic: chaotic ?? this.chaotic,
      );

  factory AlignmentValues.fromDwAlignmentValues(dw.AlignmentValues original) => AlignmentValues(
        meta: Meta.empty(createdBy: '__repo__'),
        good: original.good,
        evil: original.evil,
        lawful: original.lawful,
        neutral: original.neutral,
        chaotic: original.chaotic,
      );

  @override
  Map<String, dynamic> toJson() => {
        '_meta': meta.toJson(),
        ...super.toJson(),
      };
}
