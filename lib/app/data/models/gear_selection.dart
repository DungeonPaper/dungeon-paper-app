import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:dungeon_world_data/gear_option.dart';

class GearSelection extends dw.GearSelection {
  GearSelection({
    required String key,
    required String description,
    required List<GearOption> options,
    required int gold,
  })  : _options = options,
        super(
          key: key,
          description: description,
          options: options,
          gold: gold,
        );

  @override
  List<GearOption> get options => _options;
  final List<GearOption> _options;

  GearSelection copyWithInherited({
    String? key,
    String? description,
    List<GearOption>? options,
    int? gold,
  }) =>
      GearSelection(
        key: key ?? this.key,
        description: description ?? this.description,
        options: options ?? this.options,
        gold: gold ?? this.gold,
      );

  factory GearSelection.fromRawJson(String str) => GearSelection.fromJson(json.decode(str));

  factory GearSelection.fromDwGearSelection(dw.GearSelection gearSelection) =>
      GearSelection.fromJson(gearSelection.toJson());

  factory GearSelection.fromJson(Map<String, dynamic> json) => GearSelection(
        key: json['key'],
        description: json['description'],
        options: List<GearOption>.from(json['options'].map((x) => GearSelection.fromJson(x))),
        gold: json['gold'],
      );
}
