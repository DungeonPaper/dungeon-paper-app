import 'dart:math';

import 'package:dungeon_paper/components/standard_dialog_controls.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditCoinsDialog extends StatefulWidget {
  final num value;
  EditCoinsDialog({
    Key key,
    @required this.value,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      EditCoinsDialogState(value: value);
}

class EditCoinsDialogState extends State<EditCoinsDialog> {
  num value;
  TextEditingController _controller;

  EditCoinsDialogState({
    Key key,
    @required this.value,
  })  : _controller = TextEditingController(text: value.toString()),
        super();

  @override
  Widget build(BuildContext context) {
    num controlledStat = double.parse(_controller.value.text);

    return SimpleDialog(
      title: Text('Update Currency'),
      contentPadding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Coins: ${currency(value)}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )),
            Form(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          shape: CircleBorder(side: BorderSide.none),
                          color: Colors.red.shade300,
                          textColor: Colors.white,
                          child: Text('-', style: TextStyle(fontSize: 30)),
                          onPressed: () => _setStateValue(
                              max(0, (controlledStat - 1.0) * 100).toInt() / 100.0),
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (val) => _setStateValue(
                                num.parse(val) != 0 ? num.parse(val) : ''),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter(RegExp('[0-9\.]+'))
                            ],
                            controller: _controller,
                            autofocus: true,
                            style: TextStyle(fontSize: 24.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        RaisedButton(
                          shape: CircleBorder(side: BorderSide.none),
                          color: Colors.green.shade400,
                          textColor: Colors.white,
                          child: Text('+', style: TextStyle(fontSize: 24)),
                          onPressed: () => _setStateValue(
                              controlledStat + 1.0),
                        ),
                      ],
                    ),
                  ),
                  StandardDialogControls(
                    onOK: () => _saveValue(),
                    onCancel: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _setStateValue(num newValue) {
    setState(() {
      value = newValue;
    });

    if (newValue != double.parse(_controller.text)) {
      _controller.text = newValue.toString();
      num len = newValue.toString().length;
      _controller.selection = TextSelection(baseOffset: len, extentOffset: len);
    }
  }

  _saveValue() async {
    DbCharacter character = dwStore.state.characters.current;
    character.coins = value;
    await updateCharacter(character, [CharacterKeys.coins]);
    Navigator.pop(context);
  }
}
