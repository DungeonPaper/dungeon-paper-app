import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

import 'item.dart';

class GearSelection extends dw.GearSelection {
  GearSelection({
    required String description,
    required List<Item> items,
    required int gold,
  })  : _items = items,
        super(
          description: description,
          items: items,
          gold: gold,
        );

  @override
  List<Item> get items => _items;
  final List<Item> _items;

  GearSelection copyWithInherited({
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

  factory GearSelection.fromDwGearSelection(dw.GearSelection gearSelection) =>
      GearSelection.fromJson(gearSelection.toJson());

  factory GearSelection.fromJson(Map<String, dynamic> json) => GearSelection(
        description: json["description"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        gold: json["gold"],
      );
}
