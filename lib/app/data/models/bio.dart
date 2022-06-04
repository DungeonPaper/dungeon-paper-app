import 'dart:convert';

import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class Bio {
  Bio({
    required this.looks,
    required this.description,
    required this.alignment,
  });

  final String looks;
  final String description;
  final AlignmentValue alignment;

  Bio copyWith({
    String? looks,
    String? description,
    AlignmentValue? alignment,
  }) =>
      Bio(
        looks: looks ?? this.looks,
        description: description ?? this.description,
        alignment: alignment ?? this.alignment,
      );

  factory Bio.fromRawJson(String str) => Bio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bio.fromJson(Map<String, dynamic> json) => Bio(
        looks: json['looks']?.toString() ?? '',
        description: json['description'] ?? '',
        alignment: AlignmentValue.fromJson(json['alignment']),
      );

  factory Bio.empty() => Bio(
        description: '',
        looks: '',
        alignment: AlignmentValue(
          meta: Meta.version(1),
          type: dw.AlignmentType.good,
          description: '',
        ),
      );

  Map<String, dynamic> toJson() => {
        'looks': looks,
        'description': description,
        'alignment': alignment.toJson(),
      };
}
