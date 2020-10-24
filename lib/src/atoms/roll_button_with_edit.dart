import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/atoms/dice_icon.dart';
import 'package:dungeon_paper/src/dialogs/roll_dice_view.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class RollButtonWithEdit extends StatelessWidget {
  final List<Dice> diceList;
  final Widget label;
  final void Function() onRoll;
  final Character character;
  final String analyticsSource;
  final Brightness brightness;

  const RollButtonWithEdit({
    Key key,
    this.label,
    @required this.diceList,
    @required this.onRoll,
    @required this.character,
    @required this.analyticsSource,
    this.brightness = Brightness.dark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = brightness == Brightness.light
        ? Theme.of(context).colorScheme.onSecondary
        : Theme.of(context).colorScheme.onPrimary;
    return RaisedButton.icon(
      color: brightness == Brightness.light
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).colorScheme.primary,
      textColor: textColor,
      padding: EdgeInsets.all(12),
      icon: DiceIcon(
        dice: diceList?.first ?? (Dice.d6 * 2),
        size: 24,
        color: textColor,
      ),
      label: Flexible(
        fit: FlexFit.loose,
        child: DefaultTextStyle.merge(
          style: TextStyle(color: textColor),
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
      showDiceRollView(
        character: character,
        initialAddingDice: diceList,
        initialDiceList: diceList,
        analyticsSource: analyticsSource,
      );
    };
  }
}
