import 'package:dungeon_paper/src/atoms/dice_icon.dart';
import 'package:dungeon_paper/src/flutter_utils/input_formatters.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DiceSelector extends StatefulWidget {
  final Dice dice;
  final void Function(Dice) onChanged;
  final bool showIcon;
  final num iconSize;
  final TextStyle textStyle;

  const DiceSelector({
    Key key,
    this.onChanged,
    @required this.dice,
    this.showIcon = false,
    this.iconSize = 40,
    this.textStyle,
  }) : super(key: key);

  @override
  _DiceSelectorState createState() => _DiceSelectorState();
}

class _DiceSelectorState extends State<DiceSelector> {
  TextEditingController controller;
  Dice dice;
  num get amount => dice.amount;
  num get sides => dice.sides;

  static List<Dice> diceList = [
    Dice.d4,
    Dice.d6,
    Dice.d8,
    Dice.d10,
    Dice.d12,
    Dice.d20,
  ];

  @override
  void initState() {
    dice = widget.dice;
    controller = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.dice.amount.toString(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (widget.showIcon == true)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: DiceIcon(
                dice: dice,
                size: widget.iconSize.toDouble(),
              ),
            ),
          Container(
            width: 40,
            child: TextField(
              onChanged: (val) {
                setState(() => dice = Dice(sides, int.tryParse(val) ?? amount));
                delegateChange(dice);
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
                BetweenValuesTextFormatter(1, 99)
              ],
              controller: controller,
              style: widget.textStyle,
              textAlign: TextAlign.right,
            ),
          ),
          DropdownButton<Dice>(
            value: Dice(sides),
            items: diceList
                .map((d) => DropdownMenuItem(
                      key: Key(d.toString()),
                      value: d,
                      child: Text(
                        'd${d.sides}',
                        style: widget.textStyle,
                      ),
                    ))
                .toList(),
            onChanged: (val) {
              setState(() => dice = Dice(val.sides, amount));
              delegateChange(dice);
            },
          )
        ],
      ),
    );
  }

  void delegateChange(Dice dice) {
    if (widget.onChanged == null) {
      return;
    }
    widget.onChanged(dice);
  }
}
