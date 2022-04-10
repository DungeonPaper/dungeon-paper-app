import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

import 'meta.dart';

class AlignmentValue extends dw.AlignmentValue {
  AlignmentValue({
    required this.meta,
    required String key,
    required String description,
  }) : super(key: key, description: description);

  final Meta meta;

  factory AlignmentValue.fromRawJson(String str) => AlignmentValue.fromJson(json.decode(str));

  factory AlignmentValue.fromDwAlignmentValue(dw.AlignmentValue original) =>
      AlignmentValue(meta: Meta.version(1), key: original.key, description: original.description);

  factory AlignmentValue.fromJson(Map<String, dynamic> json) => AlignmentValue(
        meta: Meta.tryParse(json['_meta']),
        key: json['key'],
        description: json['description'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '_meta': meta,
        ...super.toJson(),
      };
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

  factory AlignmentValues.fromRawJson(String str) => AlignmentValues.fromJson(json.decode(str));

  factory AlignmentValues.fromJson(Map<String, dynamic> json) => AlignmentValues(
        meta: Meta.fromJson(json['_meta']),
        good: json['good'],
        evil: json['evil'],
        lawful: json['lawful'],
        neutral: json['neutral'],
        chaotic: json['chaotic'],
      );

  factory AlignmentValues.fromDwAlignmentValues(dw.AlignmentValues original) => AlignmentValues(
        meta: Meta.version(1),
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
