import 'package:pedantic/pedantic.dart';

import '../../components/standard_dialog_controls.dart';
import '../../flutter_utils.dart';
import '../../redux/stores/stores.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditHitDiceDialog extends StatefulWidget {
  final Dice dice;
  EditHitDiceDialog({
    Key key,
    @required this.dice,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      EditHitDiceDialogState(amount: dice.amount, sides: dice.sides);
}

class EditHitDiceDialogState extends State<EditHitDiceDialog> {
  num amount;
  num sides;
  TextEditingController _amountController;

  EditHitDiceDialogState({
    Key key,
    @required this.amount,
    @required this.sides,
  }) : _amountController = TextEditingController(text: amount.toString());

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Edit Hit Dice'),
      contentPadding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SvgPicture.asset(
                      'assets/dice.svg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Container(
                    width: 40,
                    child: TextField(
                      onChanged: (val) => _setStateAmount(int.tryParse(val)),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                        BetweenValuesTextFormatter(1, 99)
                      ],
                      controller: _amountController,
                      style: TextStyle(fontSize: 24.0),
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
                              child: Text('d${dice.sides}',
                                  style: TextStyle(fontSize: 24.0)),
                            ))
                        .toList(),
                    onChanged: (val) => _setStateSides(val.sides),
                  )
                ],
              ),
            ),
            StandardDialogControls(
              onOK: () => _saveValue(),
              onCancel: () => Navigator.pop(context),
            ),
          ],
        ),
      ],
    );
  }

  _setStateAmount(num newValue) {
    setState(() {
      amount = newValue;
    });
  }

  _setStateSides(num newValue) {
    setState(() {
      sides = newValue;
    });
  }

  _saveValue() async {
    var character = dwStore.state.characters.current;
    var dice = Dice(sides, amount);
    character.damageDice = dice;
    unawaited(character.update(json: {'hitDice': dice.toString()}));
    Navigator.pop(context);
  }
}
