import 'package:dungeon_paper/src/atoms/number_controller.dart';
import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:dungeon_paper/src/flutter_utils/input_formatters.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedantic/pedantic.dart';

class EditCoinsDialog extends StatefulWidget {
  final double value;
  EditCoinsDialog({
    Key key,
    @required this.value,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditCoinsDialogState(value: value);
}

class EditCoinsDialogState extends State<EditCoinsDialog> {
  double value;
  final TextEditingController _controller;
  bool valueError = false;

  EditCoinsDialogState({
    Key key,
    @required this.value,
  })  : _controller = TextEditingController(text: value.toString()),
        super();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Currency'),
      contentPadding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: StandardDialogControls.actions(
        context: context,
        onConfirm: () => _saveValue(),
        confirmDisabled: valueError,
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  void _setStateValue(num newValue) {
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

  void _saveValue() async {
    var character = dwStore.state.characters.current;
    character.coins = value;
    unawaited(character.update(json: {'coins': value}));
    Navigator.pop(context);
  }
}
