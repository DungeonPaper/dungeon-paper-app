import 'package:dungeon_paper/db/helpers/character_utils.dart';
import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/atoms/number_controller.dart';
import 'package:dungeon_paper/src/atoms/roll_button_with_edit.dart';
import 'package:dungeon_paper/src/dialogs/roll_dice_dialog.dart';
import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:dungeon_paper/src/flutter_utils/dice_controller.dart';
import 'package:dungeon_paper/src/molecules/dice_roll_box.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:uuid/uuid.dart';

class EditStatDialog extends StatefulWidget {
  final CharacterKeys stat;
  final num value;
  final Character character;

  EditStatDialog({
    Key key,
    @required this.stat,
    @required this.value,
    @required this.character,
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
  DiceListController rollingController;
  String rollSession;

  EditStatDialogState({
    Key key,
    @required this.stat,
    @required this.value,
  })  : fullName = CHARACTER_STAT_LABELS[stat],
        super();

  @override
  Widget build(BuildContext context) {
    var modifier = Character.statModifierText(value);
    var name = enumName(stat);
    var statName = name.toUpperCase();

    return SimpleDialog(
      title: Text('Edit $fullName'),
      contentPadding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('$fullName: $value'),
            Text(
              '${statName}: $modifier',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Form(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: 240,
                    child: NumberController(
                      min: 1,
                      max: MAX_STAT_VALUE,
                      value: value,
                      onChange: _setStateValue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: RollButtonWithEdit(
                      label: Text('Roll 2d6 + $statName'),
                      diceList: dice,
                      onRoll: _rollStat,
                      character: widget.character,
                    ),
                  ),
                  if (rollingController != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0)
                          .copyWith(bottom: 8),
                      child: DiceRollBox(
                        key: Key(rollSession),
                        controller: rollingController,
                        onRemove: _removeRoll,
                        onEdit: _editRoll,
                      ),
                    ),
                  StandardDialogControls(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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

  void _setStateValue(num newValue) {
    setState(() {
      if (newValue == null) {
        valueError = true;
      } else {
        valueError = false;
        value = newValue;
      }
    });
  }

  void _saveValue() async {
    final character = dwStore.state.characters.current;
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
    unawaited(analytics.logEvent(name: Events.EditStat));
    Navigator.pop(context);
  }

  void _removeRoll() {
    setState(() {
      rollingController = null;
      rollSession = null;
    });
  }

  void _editRoll() {
    showDiceRollDialog(
      context: context,
      character: widget.character,
      initialAddingDice: rollingController.value,
    );
  }

  void _rollStat() {
    setState(() {
      rollingController = DiceListController(dice);
      rollSession = Uuid().v4();
    });
  }

  List<Dice> get dice => [Dice(6, 2, CharacterFields.statModifier(value))];
}
