import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:flutter/material.dart';

class RollDiceDialog extends StatefulWidget {
  @override
  _RollDiceDialogState createState() => _RollDiceDialogState();
}

class _RollDiceDialogState extends State<RollDiceDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Roll Dice'),
      children: [
        StandardDialogControls(
          okText: Text('Done'),
          onOK: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
