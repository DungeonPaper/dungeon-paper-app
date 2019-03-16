import 'package:dungeon_paper/components/standard_dialog_controls.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/character_types.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditStatDialog extends StatefulWidget {
  final Stats stat;
  final num value;
  EditStatDialog({
    Key key,
    @required this.stat,
    @required this.value,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      EditStatDialogState(stat: stat, value: value);
}

class EditStatDialogState extends State<EditStatDialog> {
  final Stats stat;
  final String fullName;
  num value;
  TextEditingController _controller;

  EditStatDialogState({
    Key key,
    @required this.stat,
    @required this.value,
  })  : fullName = StatNameMap[stat],
        _controller = TextEditingController(text: value.toString()),
        super();

  @override
  Widget build(BuildContext context) {
    String modifier = DbCharacter.statModifierText(value);
    String name = enumName(stat);
    num controlledStat = int.parse(_controller.value.text);

    return SimpleDialog(
      title: Text('Edit $fullName'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('$fullName: $value'),
              Text('${name.toUpperCase()}: $modifier',
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
                                controlledStat > 1 ? controlledStat - 1 : 1),
                          ),
                          Expanded(
                            child: TextField(
                              onChanged: (val) => _setStateValue(
                                  num.parse(val) != 0 ? num.parse(val) : ''),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly,
                                BetweenValuesTextFormatter(0, 20)
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
                                controlledStat < 20 ? controlledStat + 1 : 20),
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
        ),
      ],
    );
  }

  _setStateValue(num newValue) {
    setState(() {
      value = newValue;
    });

    if (newValue != int.parse(_controller.text)) {
      _controller.text = newValue.toString();
      num len = newValue.toString().length;
      _controller.selection = TextSelection(baseOffset: len, extentOffset: len);
    }
  }

  _saveValue() async {
    DbCharacter character = dwStore.state.characters.current;
    CharacterKeys key;
    switch (stat) {
      case Stats.int:
        character.int = value;
        key = CharacterKeys.int;
        break;
      case Stats.wis:
        character.wis = value;
        key = CharacterKeys.wis;
        break;
      case Stats.cha:
        character.cha = value;
        key = CharacterKeys.cha;
        break;
      case Stats.con:
        character.con = value;
        key = CharacterKeys.con;
        break;
      case Stats.str:
        character.str = value;
        key = CharacterKeys.str;
        break;
      case Stats.dex:
        character.dex = value;
        key = CharacterKeys.dex;
        break;
    }
    await updateCharacter(character, [key]);
    Navigator.pop(context);
  }
}

class BetweenValuesTextFormatter extends TextInputFormatter {
  final num min;
  final num max;

  BetweenValuesTextFormatter(this.min, this.max);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    num newNum = int.parse(newValue.text);
    if (newNum < min || newNum > max) {
      return oldValue;
    }

    return newValue;
  }
}
