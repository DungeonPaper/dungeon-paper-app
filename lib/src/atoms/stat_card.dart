import 'package:dungeon_paper/db/helpers/character_utils.dart';
import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/dialogs/edit_stat_dialog.dart';
import 'package:dungeon_paper/src/dialogs/roll_dice_dialog.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final Character character;
  final CharacterKeys stat;

  StatCard({
    Key key,
    @required this.character,
    @required this.stat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var value = getValue(character, stat);

    return Expanded(
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: InkWell(
          onTap: _edit(context),
          onLongPress: _openRollDialog(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '${CHARACTER_STAT_LABELS[stat]}: $value',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '${CHARACTER_STAT_MODIFIER_LABELS[stat]} ' +
                      Character.statModifierText(value),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  num getValue(Character character, CharacterKeys key) {
    switch (enumName(key).toLowerCase()) {
      case 'int':
        return character.int;
      case 'dex':
        return character.dex;
      case 'wis':
        return character.wis;
      case 'cha':
        return character.cha;
      case 'str':
        return character.str;
      case 'con':
      default:
        return character.con;
    }
  }

  void Function() _edit(BuildContext context) {
    final value = getValue(character, stat);
    return () {
      showDialog(
        context: context,
        builder: (context) => EditStatDialog(
          stat: stat,
          value: value,
          character: character,
        ),
      );
    };
  }

  void Function() _openRollDialog(BuildContext context) {
    final value = getValue(character, stat);
    return () {
      showDialog(
        context: context,
        builder: (context) {
          var statDice = [Dice(6, 2, CharacterFields.statModifier(value))];
          return RollDiceDialog(
            character: character,
            initialDiceList: statDice,
            initialAddingDice: statDice,
          );
        },
      );
    };
  }
}
