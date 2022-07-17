import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:dungeon_world_data/gear_option.dart';

class GearSelection extends dw.GearSelection {
  GearSelection({
    required String key,
    required String description,
    required List<GearOption> options,
    required double coins,
  })  : _options = options,
        super(
          key: key,
          description: description,
          options: options,
          coins: coins,
        );

  @override
  List<GearOption> get options => _options;
  final List<GearOption> _options;

  GearSelection copyWithInherited({
    String? key,
    String? description,
    List<GearOption>? options,
    double? coins,
  }) =>
      GearSelection(
        key: key ?? this.key,
        description: description ?? this.description,
        options: options ?? this.options,
        coins: coins ?? this.coins,
      );

  factory GearSelection.fromRawJson(String str) => GearSelection.fromJson(json.decode(str));

  factory GearSelection.fromDwGearSelection(dw.GearSelection gearSelection) =>
      GearSelection.fromJson(gearSelection.toJson());

  factory GearSelection.fromJson(Map<String, dynamic> json) => GearSelection(
        key: json['key'],
        description: json['description'] ?? '',
        options: List<GearOption>.from((json['options'] ?? []).map((x) => GearOption.fromJson(x))),
        coins: json['coins'] ?? 0,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GearSelection &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          description == other.description &&
          options == other.options &&
          coins == other.coins;

  @override
  int get hashCode => Object.hashAll([key, description, options, coins]);

  String get debugProperties =>
      'key: $key, description: $description, options: $options, coins: $coins';

  @override
  String toString() => 'GearSelection($debugProperties)';
}
