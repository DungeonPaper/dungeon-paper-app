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
  final EdgeInsets padding;

  const DiceSelector({
    Key key,
    this.onChanged,
    @required this.dice,
    this.showIcon = false,
    this.iconSize = 40,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
  }) : super(key: key);

  @override
  _DiceSelectorState createState() => _DiceSelectorState();
}

class _DiceSelectorState extends State<DiceSelector> {
  TextEditingController amountController;
  FocusNode focusNode;
  num get amount => int.tryParse(amountController.text);
  num sides;

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
    sides = widget.dice.sides;
    amountController = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.dice.amount.toString(),
      ),
    );
    focusNode = FocusNode()..addListener(_focusListener);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.removeListener(_focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // logger.d('controller: $amountController');
    return Container(
      padding: widget.padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (widget.showIcon == true)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: DiceIcon(
                dice: Dice(sides, amount),
                size: widget.iconSize.toDouble(),
              ),
            ),
          Container(
            width: 58,
            padding: EdgeInsets.only(right: 8),
            child: TextField(
              onChanged: _updateAmount,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                BetweenValuesTextFormatter(1, 99)
              ],
              controller: amountController,
              style: widget.textStyle,
              textAlign: TextAlign.right,
              focusNode: focusNode,
            ),
          ),
          DropdownButton<Dice>(
            value: Dice(sides),
            items: [
              for (var d in diceList)
                DropdownMenuItem(
                  key: Key(d.toString()),
                  value: d,
                  child: Text(
                    'd${d.sides}',
                    style: widget.textStyle,
                  ),
                ),
            ],
            onChanged: _updateSides,
          )
        ],
      ),
    );
  }

  void _updateSides(val) {
    sides = val.sides;
    _delegateChange(Dice(sides, amount));
  }

  void _updateAmount(val) {
    var _amt = int.tryParse(val) ?? amount;
    _delegateChange(Dice(sides, _amt));
  }

  void _delegateChange(Dice dice) {
    widget.onChanged?.call(dice);
  }

  void _focusListener() {
    if (focusNode.hasFocus) {
      setState(() {
        amountController.value = amountController.value.copyWith(
          selection: TextSelection(
            baseOffset: 0,
            extentOffset: amountController.text.length,
          ),
        );
        // logger.d('set: ${amountController.value}');
      });
    }
  }
}
