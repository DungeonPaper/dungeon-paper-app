import 'dart:convert';

import 'item.dart';

class GearSelection {
  GearSelection({
    required this.description,
    required this.items,
    required this.gold,
  });

  final String description;
  final List<Item> items;
  final int gold;

  GearSelection copyWith({
    String? description,
    List<Item>? items,
    int? gold,
  }) =>
      GearSelection(
        description: description ?? this.description,
        items: items ?? this.items,
        gold: gold ?? this.gold,
      );

  factory GearSelection.fromRawJson(String str) =>
      GearSelection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GearSelection.fromJson(Map<String, dynamic> json) => GearSelection(
        description: json["description"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        gold: json["gold"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "gold": gold,
      };
}
