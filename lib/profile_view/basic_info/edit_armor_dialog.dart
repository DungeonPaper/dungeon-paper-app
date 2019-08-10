import 'package:dungeon_paper/components/standard_dialog_controls.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/flutter_utils.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditArmorDialog extends StatefulWidget {
  final num value;
  EditArmorDialog({
    Key key,
    @required this.value,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditArmorDialogState(value: value);
}

class EditArmorDialogState extends State<EditArmorDialog> {
  num value;
  TextEditingController _controller;

  EditArmorDialogState({
    Key key,
    @required this.value,
  })  : _controller = TextEditingController(text: value.toString()),
        super();

  @override
  Widget build(BuildContext context) {
    num controlledStat = int.parse(_controller.value.text);

    return SimpleDialog(
      title: Text('Edit Armor'),
      contentPadding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Armor: $value',
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
                              controlledStat > 0 ? controlledStat - 1 : 0),
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (val) =>
                                _setStateValue(int.tryParse(val)),
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
    character.armor = value;
    updateCharacter(character, [CharacterKeys.armor]);
    Navigator.pop(context);
  }
}
