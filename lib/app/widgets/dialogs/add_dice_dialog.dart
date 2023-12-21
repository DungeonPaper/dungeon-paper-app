import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/app/widgets/forms/dice_form.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

enum ModifierType { stat, fixed }

class AddDiceDialog extends StatefulWidget {
  const AddDiceDialog({
    super.key,
    this.dice,
    this.onSave,
    required this.abilityScores,
  });

  final dw.Dice? dice;
  final void Function(dw.Dice dice)? onSave;
  final AbilityScores abilityScores;

  @override
  State<AddDiceDialog> createState() => _AddDiceDialogState();
}

class _AddDiceDialogState extends State<AddDiceDialog>
    with RepositoryProviderMixin {
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
        widget.dice == null
            ? tr.generic.addEntity(tr.entity(tn(dw.Dice)))
            : tr.generic.editEntity(tr.entity(tn(dw.Dice))),
      ),
      content: SingleChildScrollView(
        child: DiceForm(
          dice: dice,
          onChanged: (dw.Dice dice) => setState(() => this.dice = dice),
          abilityScores: widget.abilityScores,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onSave?.call(dice);
            Navigator.of(context).pop();
          },
          child: Text(tr.generic.save),
        ),
      ],
    );
  }
}
