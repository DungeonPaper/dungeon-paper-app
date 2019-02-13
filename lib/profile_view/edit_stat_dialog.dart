import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/character_types.dart';
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
    String name = stat.toString().split('.')[1];
    num controlledStat = int.parse(_controller.value.text);

    return SimpleDialog(
      title: Text('Edit $fullName'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 26.0),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          RaisedButton(
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () => _saveValue(),
                            child: const Text('Save'),
                          ),
                        ],
                      ),
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
    String name = stat.toString().split('.')[1];
    await updateCharacter({name.toLowerCase(): value});
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
