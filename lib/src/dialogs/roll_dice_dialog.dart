import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/flutter_utils/dice_controller.dart';
import 'package:dungeon_paper/src/molecules/dice_roll_box.dart';
import 'package:dungeon_paper/src/molecules/dice_roll_builder.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class RollDiceDialog extends StatefulWidget {
  final Character character;
  final List<Dice> initialDiceList;
  final List<Dice> initialAddingDice;

  const RollDiceDialog({
    Key key,
    this.character,
    this.initialDiceList,
    this.initialAddingDice,
  }) : super(key: key);

  @override
  _RollDiceDialogState createState() => _RollDiceDialogState();
}

class _RollDiceDialogState extends State<RollDiceDialog> {
  List<List<Dice>> diceList;
  List<Dice> addingDice;
  List<DiceListController> controllers;

  @override
  void initState() {
    diceList = [];
    controllers = [];

    if (widget.initialDiceList?.isNotEmpty == true) {
      _addDiceToState(widget.initialDiceList).call();
    }

    if (widget.initialAddingDice?.isNotEmpty == true) {
      addingDice = [...widget.initialAddingDice];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 52,
          child: Center(
            child: Text(
              'Roll Dice',
              style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Theme.of(context).canvasColor,
                  ),
            ),
          ),
        ),
        DiceRollBuilder(
          character: widget.character,
          initialValue: addingDice,
          onChanged: _add,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var list in enumerate(reversedControllers)) ...[
                  SizedBox(height: 16),
                  DiceRollBox(
                    key: Key('dice-${list.value.hash}'),
                    controller: reversedControllers.elementAt(list.index),
                    onRemove: () => _removeAt(list.index),
                  ),
                ],
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  num reversedIndex(num idx) {
    return diceList.length - idx - 1;
  }

  Iterable<DiceListController> get reversedControllers => controllers.reversed;

  void _add(List<Dice> dice) {
    logger.d('Add dice ${dice.join(', ')}');
    analytics.logEvent(
      name: Events.RollNewDice,
      parameters: {'dice': dice.join(', ')},
    );
    setState(_addDiceToState(dice));
  }

  void Function() _addDiceToState(List<Dice> dice) {
    return () {
      var _ctrl = DiceListController([...dice]);
      controllers.add(_ctrl);
      diceList.add(dice);
    };
  }

  void _removeAt(num idx) {
    idx = reversedIndex(idx);
    logger.d('Remove dice ${diceList[idx].join(', ')}');
    analytics.logEvent(
      name: Events.RemoveDice,
      parameters: {'dice': diceList[idx].join(', ')},
    );
    setState(() {
      diceList.removeAt(idx);
      controllers.removeAt(idx);
    });
  }
}
