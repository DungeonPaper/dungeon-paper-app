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
    return RaisedButton.icon(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(12),
      icon: DiceIcon(
        dice: diceList?.first ?? (Dice.d6 * 2),
        size: 24,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      label: Flexible(
        fit: FlexFit.loose,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.button,
          textAlign: TextAlign.center,
          child: label ?? Text('Roll ${diceList.join(', ')}'),
        ),
      ),
      onPressed: onRoll,
      onLongPress: _openRollDialog(context),
    );
  }

  void Function() _openRollDialog(BuildContext context) {
    return () {
      showDialog(
        context: context,
        builder: (context) => RollDiceDialog(
          character: character,
          initialAddingDice: diceList,
          initialDiceList: diceList,
        ),
      );
    };
  }
}
