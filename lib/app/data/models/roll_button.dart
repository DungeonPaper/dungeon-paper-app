import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/core/utils/enum_utils.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

enum RollButtonType {
  damageDice,
  custom,
}

class RollButton {
  final String label;
  final List<dw.Dice> dice;
  final RollButtonType type;

  List<dw.Dice> diceFor(Character character) {
    switch (type) {
      case RollButtonType.damageDice:
        return [dw.Dice.fromJson('2d6+STR'), character.damageDice];
      case RollButtonType.custom:
      default:
        return dice;
    }
  }

  RollButton({
    required this.label,
    required this.dice,
    required this.type,
  });

  RollButton.custom({
    required this.label,
    required this.dice,
  }) : type = RollButtonType.custom;

  RollButton.damageDice({
    required this.label,
  })  : type = RollButtonType.damageDice,
        dice = const [];

  factory RollButton.fromJson(Map<String, dynamic> json) => RollButton(
        label: json['label'],
        dice: List<dw.Dice>.from(json['dice'].map((x) => dw.Dice.fromJson(x))),
        type: getEnumByName(RollButtonType.values, json['type'] ?? 'custom'),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'dice': dice.map((d) => d.toJson()).toList(),
        'type': type.name,
      };
}
