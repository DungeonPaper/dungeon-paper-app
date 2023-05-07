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
    return PrimaryChip(
      icon: icon != null ? icon! : DiceUtils.iconOf(dice),
      label: label ?? dice.toString(),
      visualDensity: visualDensity,
      backgroundColor: backgroundColor,
      onDeleted: onDeleted,
      onPressed: onPressed,
    );
  }
}
