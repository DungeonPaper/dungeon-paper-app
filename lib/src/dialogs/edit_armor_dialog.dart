import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/character/character_settings.dart';
import 'package:dungeon_paper/src/atoms/number_controller.dart';
import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:dungeon_paper/src/flutter_utils/input_formatters.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:get/get.dart';
import 'package:pedantic/pedantic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditArmorDialog extends StatefulWidget {
  final Character character;
  EditArmorDialog({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditArmorDialogState();
}

class EditArmorDialogState extends State<EditArmorDialog> {
  num value;
  bool autoCalc;

  EditArmorDialogState({
    Key key,
  }) : super();

  @override
  void initState() {
    super.initState();
    value = widget.character.armor;
    autoCalc = widget.character.settings.autoCalcArmor;
  }

  @override
  Widget build(BuildContext context) {
    final visibleValue = autoCalc ? widget.character.calculatedArmor : value;
    return AlertDialog(
      title: Text('Edit Armor'),
      contentPadding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Armor: $visibleValue',
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
                      formatType: FormatType.Integer,
                      value: value,
                      onChange: (val) => setState(() => value = val),
                      enabled: !autoCalc,
                    ),
                  ),
                  CheckboxListTile(
                    value: autoCalc,
                    onChanged: (val) => setState(() => autoCalc = val),
                    title: Text('Automatically calculate from equipped items'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      actions: StandardDialogControls.actions(
        context: context,
        onConfirm: () => _saveValue(),
        onCancel: () => Get.back(),
      ),
    );
  }

  void _saveValue() async {
    var character = dwStore.state.characters.current;
    character.settings = character.settings.copyWith(autoCalcArmor: autoCalc);
    character.armor = value;
    unawaited(character.update());
    Get.back();
  }
}
