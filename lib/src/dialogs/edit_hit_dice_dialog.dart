import 'package:dungeon_paper/src/atoms/dice_selector.dart';
import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:dungeon_paper/src/flutter_utils/input_formatters.dart';
import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:pedantic/pedantic.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditHitDiceDialog extends StatefulWidget {
  final Dice dice;
  EditHitDiceDialog({
    Key key,
    @required this.dice,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditHitDiceDialogState();
}

class EditHitDiceDialogState extends State<EditHitDiceDialog> {
  Dice dice;

  @override
  void initState() {
    dice = widget.dice;
    super.initState();
  }

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
            DiceSelector(
              dice: dice,
              showIcon: true,
              onChanged: (d) => setState(() => dice = d),
              inputTextStyle: TextStyle(fontSize: 24),
            ),
            StandardDialogControls(
              onOK: _saveValue,
              onCancel: () => Navigator.pop(context),
            ),
          ],
        ),
      ],
    );
  }

  _saveValue() async {
    var character = dwStore.state.characters.current;
    character.damageDice = dice;
    unawaited(character.update());
    Navigator.pop(context);
  }
}
