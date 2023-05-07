import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/widgets/forms/dice_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:get/get.dart';

enum ModifierType { stat, fixed }

class AddDiceDialog extends StatefulWidget {
  const AddDiceDialog({
    Key? key,
    this.dice,
    this.onSave,
    required this.abilityScores,
  }) : super(key: key);

  final dw.Dice? dice;
  final void Function(dw.Dice dice)? onSave;
  final AbilityScores abilityScores;

  @override
  State<AddDiceDialog> createState() => _AddDiceDialogState();
}

class _AddDiceDialogState extends State<AddDiceDialog> with RepositoryServiceMixin {
  late dw.Dice dice;

  @override
  void initState() {
    super.initState();
    dice = widget.dice ?? (dw.Dice.d6 * 2);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.dice == null ? S.current.addGeneric(dw.Dice) : S.current.editGeneric(dw.Dice),
      ),
      content: SingleChildScrollView(
        child: DiceForm(
          dice: dice,
          onChanged: (dw.Dice _dice) => setState(() => dice = _dice),
          abilityScores: widget.abilityScores,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onSave?.call(dice);
            Get.back();
          },
          child: Text(S.current.save),
        ),
      ],
    );
  }
}
