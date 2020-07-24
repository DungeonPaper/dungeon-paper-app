import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/atoms/dice_selector.dart';
import 'package:dungeon_paper/src/atoms/modifier_selector.dart';
import 'package:dungeon_paper/src/flutter_utils/dice_controller.dart';
import 'package:dungeon_paper/src/molecules/dice_icon_list.dart';
import 'package:dungeon_paper/src/utils/types.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class DiceRollBuilder extends StatefulWidget {
  final VoidCallbackDelegate<List<Dice>> onChanged;
  final Character character;
  final List<Dice> initialValue;

  const DiceRollBuilder({
    Key key,
    this.onChanged,
    this.character,
    this.initialValue,
  }) : super(key: key);

  @override
  _DiceRollBuilderState createState() => _DiceRollBuilderState();
}

class _DiceRollBuilderState extends State<DiceRollBuilder> {
  DiceListController addingController;

  static List<Dice> DEFAULT_DICE = [Dice.d6 * 2];

  @override
  void initState() {
    _resetController(widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      color: Theme.of(context).canvasColor,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8).copyWith(bottom: 0),
            child: Text(
              addingController.value.join(', '),
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          DiceIconList(
            key: Key(addingController.value.join(',')),
            controller: addingController,
            animations: null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var d in enumerate(addingController.value))
                  Row(
                    children: [
                      DiceSelector(
                        key: Key('d-${d.index}-${d.value}'),
                        dice: d.value,
                        textStyle: TextStyle(fontSize: 20),
                        onChanged: (val) {
                          if (val?.amount != null && val.amount > 0) {
                            _set(d.index, val);
                          }
                        },
                      ),
                      SizedBox(width: 16),
                      ModifierSelector(
                        value: d.value.modifier,
                        character: widget.character,
                        onChanged: (n) => _setMod(d.index, n),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      Expanded(child: Container()),
                      if (addingController.value.length > 1)
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _remove(d.index),
                          tooltip: 'Remove dice',
                        )
                    ],
                  ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _addRow,
                      tooltip: 'Add dice',
                    ),
                    IconButton(
                      color: Theme.of(context).primaryColor,
                      icon: Icon(Icons.check),
                      onPressed: _onAdd,
                      tooltip: 'Roll & Reset',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _set(int idx, Dice dice) {
    setState(() {
      addingController[idx] =
          Dice(dice.sides, dice.amount, addingController[idx].modifier);
    });
  }

  void _setMod(int idx, int mod) {
    setState(() {
      addingController.setMod(idx, mod);
    });
  }

  void _remove(int idx) {
    setState(() {
      addingController.removeAt(idx);
    });
  }

  void _onAdd() {
    widget.onChanged?.call(addingController.value);
    setState(_resetController);
  }

  void _addRow() {
    setState(() {
      addingController.add(Dice.d6 * 2);
    });
  }

  void _resetController([List<Dice> initialDice]) {
    addingController =
        DiceListController(initialDice ?? List.from(DEFAULT_DICE));
  }
}
