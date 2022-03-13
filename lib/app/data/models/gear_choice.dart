import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import '../../data/models/gear_selection.dart';
import 'item.dart';

class GearChoice extends dw.GearChoice {
  GearChoice({
    required String key,
    required String description,
    required List<GearSelection> selections,
  })  : _selections = selections,
        super(
          key: key,
          description: description,
          selections: selections,
        );

  @override
  List<GearSelection> get selections => _selections;
  final List<GearSelection> _selections;

  GearChoice copyWithInherited({
    String? key,
    String? description,
    List<GearSelection>? selections,
  }) =>
      GearChoice(
        key: key ?? this.key,
        description: description ?? this.description,
        selections: selections ?? this.selections,
      );

  factory GearChoice.fromRawJson(String str) => GearChoice.fromJson(json.decode(str));

  factory GearChoice.fromDwGearChoice(dw.GearChoice gearChoice) => GearChoice(
        key: gearChoice.key,
        description: gearChoice.description,
        selections: gearChoice.selections.map((s) => GearSelection.fromDwGearSelection(s)).toList(),
      );

  factory GearChoice.fromJson(Map<String, dynamic> json) =>
      GearChoice.fromDwGearChoice(dw.GearChoice.fromJson(json));

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'selections': List<dynamic>.from(selections.map((x) => x.toJson())),
      };

  static List<Item> selectionToItems(List<GearSelection> selections, {bool equipped = false}) =>
      selections.fold<List<Item>>([], (acc, sel) {
        return [
          ...acc,
          ...sel.options.map(
            (opt) => Item.fromDwItem(opt.item, amount: opt.amount, equipped: equipped),
          )
        ];
      });

  static double selectionToCoins(List<GearSelection> selections) =>
      selections.fold<double>(0, (acc, sel) {
        return acc + sel.coins;
      });
}
