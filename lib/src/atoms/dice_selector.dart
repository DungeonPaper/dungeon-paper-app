import 'package:dungeon_paper/src/flutter_utils/input_formatters.dart';
import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DiceSelector extends StatefulWidget {
  final Dice dice;
  final void Function(Dice) onChanged;
  final bool showIcon;
  final num iconSize;
  final TextStyle inputTextStyle;

  const DiceSelector({
    Key key,
    this.onChanged,
    @required this.dice,
    this.showIcon = false,
    this.iconSize = 40,
    this.inputTextStyle,
  }) : super(key: key);

  @override
  _DiceSelectorState createState() => _DiceSelectorState();
}

class _DiceSelectorState extends State<DiceSelector> {
  TextEditingController controller;
  Dice dice;
  num get amount => dice.amount;
  num get sides => dice.sides;

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
              child: PlatformSvg.asset(
                'dice.svg',
                width: widget.iconSize.toDouble(),
                height: widget.iconSize.toDouble(),
              ),
            ),
          Container(
            width: 40,
            child: TextField(
              onChanged: (val) =>
                  setState(() => dice.amount = int.tryParse(val) ?? amount),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
                BetweenValuesTextFormatter(1, 99)
              ],
              controller: controller,
              style: widget.inputTextStyle,
              textAlign: TextAlign.right,
            ),
          ),
          DropdownButton<Dice>(
            value: Dice(sides),
            items: [
              Dice.d4,
              Dice.d6,
              Dice.d8,
              Dice.d10,
              Dice.d12,
              Dice.d20,
            ]
                .map((dice) => DropdownMenuItem(
                      key: Key(dice.toString()),
                      value: dice,
                      child: Text(
                        'd${dice.sides}',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ))
                .toList(),
            onChanged: (val) => setState(() => dice.sides = val.sides),
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
