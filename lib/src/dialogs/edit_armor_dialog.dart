import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/atoms/number_controller.dart';
import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:dungeon_paper/src/flutter_utils/input_formatters.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:get/get.dart';
import 'package:pedantic/pedantic.dart';
import 'package:flutter/material.dart';

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

  EditArmorDialogState({
    Key key,
  }) : super();

  @override
  void initState() {
    super.initState();
    value = widget.character.baseArmor;
  }

  @override
  Widget build(BuildContext context) {
    final equippedArmor = widget.character.equippedArmor;
    return AlertDialog(
      title: Text('Edit Base Armor'),
      contentPadding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DefaultTextStyle.merge(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total armor: '),
                  value != widget.character.baseArmor
                      ? Wrap(
                          children: [
                            Text(widget.character.armor.toString()),
                            Icon(Icons.arrow_right_alt),
                            Text((value + widget.character.equippedArmor)
                                .toString()),
                          ],
                        )
                      : Text(widget.character.armor.toString()),
                ],
              ),
            ),
            Text('Equipped armor: $equippedArmor'),
            Form(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: NumberController(
                  decoration: InputDecoration(
                    labelText: 'Base armor',
                    hintText: '0',
                  ),
                  formatType: FormatType.Integer,
                  value: value,
                  min: 0,
                  max: 20,
                  onChange: (val) => setState(() => value = val ?? 0),
                ),
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
    character.baseArmor = value;
    unawaited(character.update());
    Get.back();
  }
}
