import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
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

  factory DiceIcon.dice(dw.Dice dice, {Key? key}) => DiceIcon(
        key: key,
        sides: dice.sides,
      );

  @override
  Widget build(BuildContext context) {
    return SvgIcon(
      DwIcons.diceIcon(sides),
      size: size,
      color: color,
    );
  }
}
