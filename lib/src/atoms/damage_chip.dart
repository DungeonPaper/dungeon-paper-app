import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/atoms/dice_icon.dart';
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
    return Tooltip(
      message: 'This is auto calculated from "Damage" tags\n'
          'on equipped inventory items,\n'
          'and is added to your "Roll Damage"\n'
          'button roll on the Battle tab.',
      showDuration: Duration(seconds: 6),
      child: Chip(
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
                Text('EQP. DAMAGE'),
                SizedBox(width: 10),
                DiceIcon(
                  dice: character.damageDice,
                  size: 20,
                ),
                SizedBox(width: 10),
                Text('$damage'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
