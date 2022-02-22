import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:dungeon_world_data/gear_option.dart';

class GearSelection extends dw.GearSelection {
  GearSelection({
    required String description,
    required List<GearOption> items,
    required int gold,
  })  : _items = items,
        super(
          description: description,
          items: items,
          gold: gold,
        );

  @override
  List<GearOption> get items => _items;
  final List<GearOption> _items;

  GearSelection copyWithInherited({
    String? description,
    List<GearOption>? items,
    int? gold,
  }) =>
      GearSelection(
        description: description ?? this.description,
        items: items ?? this.items,
        gold: gold ?? this.gold,
      );

  factory GearSelection.fromRawJson(String str) => GearSelection.fromJson(json.decode(str));

  factory GearSelection.fromDwGearSelection(dw.GearSelection gearSelection) =>
      GearSelection.fromJson(gearSelection.toJson());

  factory GearSelection.fromJson(Map<String, dynamic> json) => GearSelection(
        description: json['description'],
        items: List<GearOption>.from(json['items'].map((x) => GearSelection.fromJson(x))),
        gold: json['gold'],
      );
}
