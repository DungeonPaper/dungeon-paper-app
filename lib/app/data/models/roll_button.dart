import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class RollButton {
  final String label;
  final List<dw.Dice> dice;

  RollButton({
    required this.label,
    required this.dice,
  });

  factory RollButton.fromJson(Map<String, dynamic> json) => RollButton(
        label: json['label'],
        dice: List<dw.Dice>.from(json['dice'].map((x) => dw.Dice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'dice': dice.map((d) => d.toJson()).toList(),
      };
}
