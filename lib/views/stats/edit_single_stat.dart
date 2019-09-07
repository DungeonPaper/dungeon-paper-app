import 'package:dungeon_paper/components/number_controller.dart';
import 'package:dungeon_paper/components/standard_dialog_controls.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/character_db.dart';
import 'package:dungeon_paper/db/character_utils.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';

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
  bool saving = false;

  EditStatDialogState({
    Key key,
    @required this.stat,
    @required this.value,
  })  : fullName = StatNameMap[stat],
        super();

  @override
  Widget build(BuildContext context) {
    String modifier = DbCharacter.statModifierText(value);
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
                    width: 150,
                    child: NumberController(
                      value: value,
                      onChange: _setStateValue,
                    ),
                  ),
                  StandardDialogControls(
                    onOK: saving ? null : _saveValue,
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
  }

  _saveValue() async {
    final DbCharacter character = dwStore.state.characters.current;
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
    setState(() {
      saving = true;
    });
    await updateCharacter(character, [key]);
    Navigator.pop(context);
  }
}
