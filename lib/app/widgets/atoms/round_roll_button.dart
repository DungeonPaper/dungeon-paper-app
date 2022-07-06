import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class RoundRollButton extends StatelessWidget {
  const RoundRollButton({
    Key? key,
    required this.dice,
    this.size = 50,
  }) : super(key: key);

  final List<Dice> dice;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bgColor = colorScheme.primary;
    final fgColor = ThemeData.estimateBrightnessForColor(bgColor) == Brightness.light
        ? Colors.black
        : Colors.white;
    return ElevatedButton(
      child: Icon(
        DwIcons.dice_d6,
        size: size / 2,
        // color: fgColor,
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.square(size),
        onPrimary: fgColor,
        primary: bgColor,
      ),
      onPressed: () => DiceUtils.openRollDialog(dice),
    );
  }
}
