import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/atoms/dice_icon.dart';
import 'package:dungeon_paper/src/dialogs/roll_dice_dialog.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class RollButtonWithEdit extends StatelessWidget {
  final List<Dice> diceList;
  final Widget label;
  final void Function() onRoll;
  final Character character;

  const RollButtonWithEdit({
    Key key,
    @required this.diceList,
    this.label,
    @required this.onRoll,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RaisedButton.icon(
            color: Theme.of(context).primaryColor,
            icon: DiceIcon(
              dice: diceList?.first ?? (Dice.d6 * 2),
              size: 24,
            ),
            label: label ?? Text('Roll ${diceList.join(', ')}'),
            onPressed: onRoll,
            onLongPress: _openRollDialog(context, rollImmediately: true),
          ),
        ),
        SizedBox(width: 4),
        ButtonTheme(
          minWidth: 40,
          child: Tooltip(
            message: 'Edit in Roll Dice dialog',
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Icon(Icons.edit),
              onPressed: _openRollDialog(context),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  void Function() _openRollDialog(
    BuildContext context, {
    bool rollImmediately = false,
  }) {
    return () {
      showDialog(
        context: context,
        builder: (context) => RollDiceDialog(
          character: character,
          initialAddingDice: rollImmediately ? [] : diceList,
          initialDiceList: rollImmediately ? diceList : [],
        ),
      );
    };
  }
}
