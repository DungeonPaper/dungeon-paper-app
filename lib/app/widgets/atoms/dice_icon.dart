import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class DiceIcon extends StatelessWidget {
  const DiceIcon({
    Key? key,
    required this.sides,
    this.size,
    this.color,
  }) : super(key: key);

  final int sides;
  final double? size;
  final Color? color;

  DiceIcon.from(
    dw.Dice dice, {
    Key? key,
    this.size,
    this.color,
  })  : sides = dice.sides,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      DwIcons.diceIcon(sides),
      size: size,
      color: color,
    );
  }
}
