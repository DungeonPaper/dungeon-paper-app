import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/atoms/dice_icon.dart';
import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DamageChip extends StatelessWidget {
  final Character character;

  const DamageChip({
    Key key,
    @required this.character,
  }) : super(key: key);

  num get damage => character.equippedDamage;

  @override
  Widget build(BuildContext context) {
    return Chip(
      visualDensity: VisualDensity.compact,
      backgroundColor: Colors.red[900],
      padding: EdgeInsets.all(8),
      label: IconTheme(
        data: IconThemeData(color: Colors.white),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: Colors.white),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('DAMAGE'),
              SizedBox(width: 10),
              DiceIcon(
                dice: Dice.d6,
                size: 20,
              ),
              SizedBox(width: 10),
              Text('$damage'),
            ],
          ),
        ),
      ),
    );
  }
}
