import 'dart:convert';

import 'package:dungeon_paper/app/data/models/alignment.dart';

class Bio {
  Bio({
    required this.looks,
    required this.description,
    required this.alignment,
  });

  final List<String> looks;
  final String description;
  final AlignmentValue alignment;

  Bio copyWith({
    List<String>? looks,
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
        looks: List<String>.from(json['looks'].map((x) => x)),
        description: json['description'],
        alignment: AlignmentValue.fromJson(json['alignment']),
      );

  Map<String, dynamic> toJson() => {
        'looks': List<dynamic>.from(looks.map((x) => x)),
        'description': description,
        'alignment': alignment.toJson(),
      };
}
