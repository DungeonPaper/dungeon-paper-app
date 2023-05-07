import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/widgets/forms/dice_form.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class DamageDiceDialog extends StatefulWidget {
  const DamageDiceDialog({
    super.key,
    required this.damage,
    required this.defaultDamage,
    required this.onChanged,
    required this.abilityScores,
  });

  final dw.Dice? damage;
  final dw.Dice defaultDamage;
  final void Function(dw.Dice? damage) onChanged;
  final AbilityScores abilityScores;

  @override
  State<DamageDiceDialog> createState() => _DamageDiceDialogState();
}

class _DamageDiceDialogState extends State<DamageDiceDialog> {
  late bool useDefault;
  late dw.Dice damage;

  @override
  void initState() {
    super.initState();
    damage = widget.damage ?? (dw.Dice.d6 * 2);
    useDefault = widget.damage == null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(DwIcons.dumbbell, size: 32),
          const SizedBox(width: 12),
          Expanded(child: Text(S.current.damageDice)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            CheckboxListTile(
              title: Text(S.current.characterAutoDamage),
              dense: true,
              visualDensity: VisualDensity.compact,
              controlAffinity: ListTileControlAffinity.leading,
              value: useDefault,
              onChanged: (value) => setState(() {
                final _value = value ?? !useDefault;
                useDefault = _value;
                if (_value) {
                  damage = widget.defaultDamage;
                }
              }),
            ),
            const SizedBox(height: 8),
            DiceForm(
              dice: damage,
              onChanged: (dw.Dice _dice) => setState(() => damage = _dice),
              abilityScores: widget.abilityScores,
              enabled: !useDefault,
            ),
          ],
        ),
      ),
      actions: DialogControls.save(context, onSave: save, onCancel: cancel),
    );
  }

  void save() {
    widget.onChanged(useDefault ? null : damage);
    Get.back();
  }

  void cancel() {
    Get.back();
  }
}
