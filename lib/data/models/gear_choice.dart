import 'dart:convert';

import 'gear_selection.dart';

class GearChoice {
  GearChoice({
    required this.key,
    required this.description,
    required this.selections,
  });

  final String key;
  final String description;
  final List<GearSelection> selections;

  GearChoice copyWith({
    String? key,
    String? description,
    List<GearSelection>? selections,
  }) =>
      GearChoice(
        key: key ?? this.key,
        description: description ?? this.description,
        selections: selections ?? this.selections,
      );

  factory GearChoice.fromRawJson(String str) =>
      GearChoice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GearChoice.fromJson(Map<String, dynamic> json) => GearChoice(
        key: json["key"],
        description: json["description"],
        selections: List<GearSelection>.from(
            json["selections"].map((x) => GearSelection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "description": description,
        "selections": List<dynamic>.from(selections.map((x) => x.toJson())),
      };
}
