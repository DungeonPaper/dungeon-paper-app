import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/core/utils/enum_utils.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

enum SpecialDice {
  damage,
}

class RollButton {
  final String label;
  final List<dw.Dice> dice;
  final List<SpecialDice> specialDice;

  List<dw.Dice> diceFor(Character character) {
    return dice + specialDiceFor(character, specialDice);
  }

  RollButton({
    required this.label,
    required this.dice,
    required this.specialDice,
  });

  factory RollButton.fromJson(Map<String, dynamic> json) => RollButton(
        label: json['label'],
        dice: List<dw.Dice>.from((json['dice'] ?? []).map((x) => dw.Dice.fromJson(x))),
        specialDice: List<SpecialDice>.from(
          (json['specialDice'] ?? []).map((x) => getEnumByName(SpecialDice.values, x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'dice': dice.map((d) => d.toJson()).toList(),
        'specialDice': specialDice.map((d) => d.name).toList(),
      };

  List<dw.Dice> specialDiceFor(Character character, List<SpecialDice> specialDice) => specialDice
      .map((d) {
        switch (d) {
          case SpecialDice.damage:
            return character.damageDice;
          default:
            return null;
        }
      })
      .whereType<dw.Dice>()
      .toList();
}
