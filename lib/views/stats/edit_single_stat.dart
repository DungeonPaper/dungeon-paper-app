import 'package:dungeon_paper/components/number_controller.dart';
import 'package:dungeon_paper/components/standard_dialog_controls.dart';
import 'package:dungeon_paper/db/character_utils.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';

class EditStatDialog extends StatefulWidget {
  final CharacterKeys stat;
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
  final CharacterKeys stat;
  final String fullName;
  num value;
  bool valueError = false;
  bool saving = false;

  EditStatDialogState({
    Key key,
    @required this.stat,
    @required this.value,
  })  : fullName = CHARACTER_STAT_LABELS[stat],
        super();

  @override
  Widget build(BuildContext context) {
    String modifier = Character.statModifierText(value);
    String name = enumName(stat);

    return SimpleDialog(
      title: Text('Edit $fullName'),
      contentPadding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
      children: <Widget>[
        Column(
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
                    width: 240,
                    child: NumberController(
                      min: 1,
                      max: MAX_STAT_VALUE,
                      value: value,
                      onChange: _setStateValue,
                    ),
                  ),
                  StandardDialogControls(
                    onOK: saving ? null : _saveValue,
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
    setState(() {
      if (newValue == null) {
        valueError = true;
      } else {
        valueError = false;
        value = newValue;
      }
    });
  }

  _saveValue() async {
    final Character character = dwStore.state.characters.current;
    String key;

    switch (stat) {
      case CharacterKeys.int:
        character.int = value;
        key = 'int';
        break;
      case CharacterKeys.wis:
        character.wis = value;
        key = 'wis';
        break;
      case CharacterKeys.cha:
        character.cha = value;
        key = 'cha';
        break;
      case CharacterKeys.con:
        character.con = value;
        key = 'con';
        break;
      case CharacterKeys.str:
        character.str = value;
        key = 'str';
        break;
      case CharacterKeys.dex:
        character.dex = value;
        key = 'dex';
        break;
      default:
        break;
    }
    setState(() {
      saving = true;
    });
    await character.update(json: {key: value});
    Navigator.pop(context);
  }
}
