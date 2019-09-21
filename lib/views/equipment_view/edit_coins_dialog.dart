import 'package:dungeon_paper/components/number_controller.dart';
import 'package:dungeon_paper/components/standard_dialog_controls.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/character_db.dart';
import 'package:dungeon_paper/db/character_utils.dart';
import 'package:dungeon_paper/flutter_utils.dart';
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
  State<StatefulWidget> createState() => EditCoinsDialogState(value: value);
}

class EditCoinsDialogState extends State<EditCoinsDialog> {
  num value;
  TextEditingController _controller;
  bool valueError = false;

  EditCoinsDialogState({
    Key key,
    @required this.value,
  })  : _controller = TextEditingController(text: value.toString()),
        super();

  @override
  Widget build(BuildContext context) {
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
                    child: NumberController(
                      value: value,
                      formatType: FormatType.Decimal,
                      onChange: _setStateValue,
                    ),
                  ),
                  StandardDialogControls(
                    onOK: () => _saveValue(),
                    okDisabled: valueError,
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
    if (newValue == null) {
      setState(() {
        valueError = true;
      });
      return;
    }
    setState(() {
      value = newValue;
      valueError = false;
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
