import 'package:dungeon_paper/src/atoms/dice_selector.dart';
import 'package:dungeon_paper/src/flutter_utils/dice_controller.dart';
import 'package:dungeon_paper/src/molecules/dice_icon_list.dart';
import 'package:dungeon_paper/src/molecules/dice_roll_box.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class RollDiceDialog extends StatefulWidget {
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
              diceList: list.value.value,
              controller: controllers[list.index],
              onRemove: () => _removeAt(list.index),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            color: Theme.of(context).canvasColor,
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: DiceIconList(
                    // key: Key(
                    //     'd-${addingController.value.length}-${addingController.value.map((el) => el.toString()).join(',')}'),
                    diceList: addingController.value,
                    controller: addingController,
                    animations: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var d in enumerate(addingController.value))
                        DiceSelector(
                          key: Key('d-${d.index}-${d.value}'),
                          dice: d.value,
                          textStyle: TextStyle(fontSize: 20),
                          onChanged: _set,
                        ),
                      IconButton(
                        color: Theme.of(context).primaryColor,
                        icon: Icon(Icons.check),
                        onPressed: () => _add(addingController.value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _add(List<Dice> dice) {
    setState(() {
      var _ctrl = DiceListController(dice);
      controllers.add(_ctrl);
      diceList.add(dice);
      addingController.value = [Dice(dice.first?.sides ?? 20)];
    });
  }

  void _set(Dice dice) {
    setState(() {
      addingController.value = [dice];
    });
  }

  void _removeAt(num idx) {
    setState(() {
      diceList.removeAt(idx);
      controllers.removeAt(idx);
    });
  }
}
