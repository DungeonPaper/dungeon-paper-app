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

  const DiceRollBuilder({
    Key key,
    this.onChanged,
    this.character,
  }) : super(key: key);

  @override
  _DiceRollBuilderState createState() => _DiceRollBuilderState();
}

class _DiceRollBuilderState extends State<DiceRollBuilder> {
  DiceListController addingController;

  static List<Dice> DEFAULT_DICE = [Dice.d6 * 2];

  @override
  void initState() {
    addingController = DiceListController(DEFAULT_DICE);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).canvasColor,
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: DiceIconList(
              key: Key(addingController.value.join(',')),
              controller: addingController,
              animations: null,
            ),
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
                        key: Key('d-${d.index}'),
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
                      if (addingController.value.length > 1)
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => _remove(d.index),
                        )
                    ],
                  ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _addRow,
                    ),
                    IconButton(
                      color: Theme.of(context).primaryColor,
                      icon: Icon(Icons.check),
                      onPressed: _onAdd,
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
  }

  void _addRow() {
    setState(() {
      addingController.add(Dice.d6 * 2);
    });
  }
}
