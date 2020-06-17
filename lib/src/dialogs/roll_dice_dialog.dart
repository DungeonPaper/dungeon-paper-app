import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/flutter_utils/dice_controller.dart';
import 'package:dungeon_paper/src/molecules/dice_roll_box.dart';
import 'package:dungeon_paper/src/molecules/dice_roll_builder.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class RollDiceDialog extends StatefulWidget {
  final Character character;

  const RollDiceDialog({
    Key key,
    this.character,
  }) : super(key: key);

  @override
  _RollDiceDialogState createState() => _RollDiceDialogState();
}

class _RollDiceDialogState extends State<RollDiceDialog> {
  DiceListController addingController;
  final List<List<Dice>> diceList = [];
  final List<DiceListController> controllers = [];

  @override
  void initState() {
    addingController = DiceListController([Dice.d20]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Roll Dice'),
      titlePadding: EdgeInsets.all(16).copyWith(bottom: 0),
      children: [
        for (var list in enumerate(controllers))
          Padding(
            padding: list.index > 0
                ? const EdgeInsets.symmetric(vertical: 16)
                : EdgeInsets.only(bottom: 16),
            child: DiceRollBox(
              key: Key('dice-${list.value.hash}'),
              diceList: list.value.flat,
              controller: controllers[list.index],
              onRemove: () => _removeAt(list.index),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DiceRollBuilder(
            character: widget.character,
            onChanged: _add,
          ),
        ),
      ],
    );
  }

  void _add(List<Dice> dice) {
    setState(() {
      var _ctrl = DiceListController([...dice]);
      controllers.add(_ctrl);
      diceList.add(dice);
    });
  }

  void _removeAt(num idx) {
    setState(() {
      diceList.removeAt(idx);
      controllers.removeAt(idx);
    });
  }
}
