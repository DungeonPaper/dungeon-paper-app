import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
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
    this.visualDensity,
    this.label,
  }) : super(key: key);

  final dw.Dice dice;
  final void Function()? onPressed;
  final void Function()? onDeleted;
  final Widget? icon;
  final Color? backgroundColor;
  final VisualDensity? visualDensity;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final fgColor =
        theme.brightness == Brightness.light ? colorScheme.onPrimary : colorScheme.onSurface;
    final bgColor =
        theme.brightness == Brightness.light ? colorScheme.primary : colorScheme.surface;
    return PrimaryChip(
      // deleteIconColor: Theme.of(context).colorScheme.onPrimary,
      icon: icon != null ? icon! : DiceUtils.iconOf(dice),
      label: label ?? dice.toString(),
      visualDensity: visualDensity,
      backgroundColor: backgroundColor,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // isEnabled: true,
      onDeleted: onDeleted,
      onPressed: onPressed,
    );
    // return AdvancedChip(
    //   // deleteIconColor: Theme.of(context).colorScheme.onPrimary,
    //   avatar: IconTheme.merge(
    //     data: IconThemeData(
    //       size: 16,
    //       color: fgColor,
    //     ),
    //     child: icon != null ? icon! : DiceUtils.iconOf(dice),
    //   ),
    //   label: DefaultTextStyle.merge(
    //     style: TextStyle(color: fgColor),
    //     child: label ?? Text(dice.toString()),
    //   ),
    //   backgroundColor: bgColor.withOpacity(0.7),
    //   labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
    //   // visualDensity: VisualDensity.compact,
    //   // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    //   isEnabled: true,
    //   onDeleted: onDeleted,
    //   onPressed: onPressed,
    // );
  }
}
