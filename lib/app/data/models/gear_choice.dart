import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import '../../data/models/gear_selection.dart';
import 'item.dart';

class GearChoice extends dw.GearChoice {
  GearChoice({
    required String key,
    required String description,
    required List<GearSelection> selections,
    List<int> preselect = const [],
    int? maxSelections,
  })  : _selections = selections,
        super(
          key: key,
          description: description,
          selections: selections,
          preselect: preselect,
          maxSelections: maxSelections,
        );

  @override
  List<GearSelection> get selections => _selections;
  final List<GearSelection> _selections;

  GearChoice copyWithInherited({
    String? key,
    String? description,
    List<GearSelection>? selections,
    List<int>? preselect,
    int? maxSelections,
  }) =>
      GearChoice(
        key: key ?? this.key,
        description: description ?? this.description,
        selections: selections ?? this.selections,
        preselect: preselect ?? this.preselect,
        maxSelections: maxSelections ?? this.maxSelections,
      );

  factory GearChoice.fromRawJson(String str) => GearChoice.fromJson(json.decode(str));

  factory GearChoice.fromDwGearChoice(dw.GearChoice gearChoice) => GearChoice(
        key: gearChoice.key,
        description: gearChoice.description,
        selections: gearChoice.selections.map((s) => GearSelection.fromDwGearSelection(s)).toList(),
        preselect: gearChoice.preselect,
        maxSelections: gearChoice.maxSelections,
      );

  factory GearChoice.fromJson(Map<String, dynamic> json) =>
      GearChoice.fromDwGearChoice(dw.GearChoice.fromJson(json));

  @override
  List<GearSelection> get preselectedGearSelections =>
      super.preselectedGearSelections.map((e) => GearSelection.fromDwGearSelection(e)).toList();

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
