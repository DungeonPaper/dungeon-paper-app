import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/app/widgets/chips/advanced_chip.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:flutter/material.dart';

import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class DiceChip extends StatelessWidget {
  const DiceChip({
    Key? key,
    required this.dice,
    this.onPressed,
    this.onDeleted,
    this.icon,
    this.backgroundColor,
    this.label,
  }) : super(key: key);

  final dw.Dice dice;
  final void Function()? onPressed;
  final void Function()? onDeleted;
  final Widget? icon;
  final Color? backgroundColor;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AdvancedChip(
      deleteIconColor: Theme.of(context).colorScheme.onPrimary,
      avatar: IconTheme(
        data: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
          size: 16,
        ),
        child: icon != null ? icon! : DiceUtils.iconOf(dice),
      ),
      label: DefaultTextStyle.merge(
        style: TextStyle(color: theme.colorScheme.onPrimary),
        child: label ?? Text(dice.toString()),
      ),
      backgroundColor: backgroundColor ?? theme.primaryColor.withOpacity(0.7),
      labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      isEnabled: true,
      onDeleted: onDeleted,
      onPressed: onPressed,
    );
  }
}
