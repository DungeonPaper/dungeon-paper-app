import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/app/widgets/atoms/background_icon_button.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class RollDiceButton extends StatelessWidget {
  const RollDiceButton({
    Key? key,
    required this.dice,
    this.size = 50,
  }) : super(key: key);

  final List<Dice> dice;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      // elevation: 1.5,
      child: Icon(
        DwIcons.dice_d6,
        size: size / 2,
        color: theme.colorScheme.onSecondary,
      ),
      // iconColor: theme.elevatedButtonTheme.style?.backgroundColor?.resolve({}),
      // color: theme.buttonTheme.colorScheme!.background,
      // size: size,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.square(size),
        primary: theme.colorScheme.secondary,
      ),
      onPressed: () => DiceUtils.openRollDialog(dice),
    );
  }
}
