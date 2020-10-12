import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/atoms/dice_selector.dart';
import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:dungeon_paper/src/utils/types.dart';
import 'package:pedantic/pedantic.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class EditDamageDiceDialog extends StatefulWidget {
  final Character character;
  final VoidCallbackDelegate<Character> onSave;

  EditDamageDiceDialog({
    Key key,
    @required this.character,
    this.onSave,
  }) : super(key: key);

  Dice get dice => character.damageDice;

  @override
  State<StatefulWidget> createState() => EditDamageDiceDialogState();
}

class EditDamageDiceDialogState extends State<EditDamageDiceDialog> {
  Dice dice;

  @override
  void initState() {
    dice = widget.dice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Damage Dice'),
      contentPadding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DiceSelector(
              dice: dice,
              showIcon: true,
              onChanged: (d) => setState(() => dice = d),
              textStyle: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      actions: StandardDialogControls.actions(
        context: context,
        onConfirm: _saveValue,
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  Character get character => widget.character;

  void _saveValue() async {
    character.damageDice = dice;
    unawaited(character.update());
    Navigator.pop(context);
  }
}
