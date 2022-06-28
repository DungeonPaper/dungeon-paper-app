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
    required this.onChanged,
    required this.abilityScores,
  });

  final dw.Dice? damage;
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
            ListTile(
              minLeadingWidth: 20,
              onTap: () => setState(() {
                useDefault = !useDefault;
              }),
              visualDensity: VisualDensity.compact,
              leading: SizedBox(
                width: 20,
                child: Checkbox(
                  value: useDefault,
                  onChanged: (value) => setState(() {
                    useDefault = value!;
                  }),
                ),
              ),
              // TODO intl
              title: const Text('Use damage dice from class & equipped items'),
            ),
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

  void _listener() {
    setState(() {});
  }
}
