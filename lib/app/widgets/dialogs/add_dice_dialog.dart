import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:get/get.dart';

class AddDiceDialog extends StatefulWidget {
  const AddDiceDialog({
    Key? key,
    this.dice,
    this.onSave,
  }) : super(key: key);

  final dw.Dice? dice;
  final void Function(dw.Dice dice)? onSave;

  @override
  State<AddDiceDialog> createState() => _AddDiceDialogState();
}

enum ModifierType { stat, fixed }

class _AddDiceDialogState extends State<AddDiceDialog> {
  final RepositoryService repo = Get.find();
  // late int amount;
  late final TextEditingController amount;
  late int sides;
  late int? modifierNum;
  late String? modifierStat;
  late ModifierType modifierType;

  @override
  void initState() {
    super.initState();
    // amount = widget.dice?.amount ?? 2;
    amount = TextEditingController(text: widget.dice?.amount.toString() ?? '2');
    sides = widget.dice?.sides ?? 6;
    modifierNum = widget.dice?.modifierValue;
    modifierStat = widget.dice?.modifierStat;
    modifierType = widget.dice?.modifierStat != null ? ModifierType.stat : ModifierType.fixed;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.current.createGeneric(dw.Dice)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: amount,
            inputFormatters: [],
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              filled: true,
              label: Text(S.current.diceAmount),
            ),
          ),
          const SizedBox(height: 8),
          const Text('d'),
          const SizedBox(height: 24),
          DropdownButton<int>(
            value: sides,
            items: [
              for (final i in [4, 6, 8, 10, 12, 20, 100])
                DropdownMenuItem<int>(child: Text(i.toString()), value: i)
            ],
            onChanged: (value) => setState(() {
              if (value != null) {
                sides = value;
              }
            }),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onSave?.call(createDice());
            Get.back();
          },
          child: Text(S.current.save),
        ),
      ],
    );
  }

  dw.Dice createDice() => dw.Dice(
        amount: int.tryParse(amount.text) ?? 1,
        sides: sides,
      );

  dynamic tryParse(String text) {
    if (RegExp(r'[a-z]').hasMatch(text)) {
      return text;
    }
    if (RegExp(r'[.]').hasMatch(text)) {
      return double.tryParse(text);
    }

    return int.tryParse(text);
  }
}
