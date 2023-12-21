import 'dart:math';

import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/widgets/atoms/hp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/app/widgets/molecules/value_change_slider.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

enum ValueChange { positive, neutral, negative }

class HPDialog extends StatefulWidget {
  const HPDialog({super.key});

  @override
  State<HPDialog> createState() => _HPDialogState();
}

class _HPDialogState extends State<HPDialog> with CharacterProviderMixin {
  late int overrideHP;
  late bool shouldOverrideMaxHP;
  late TextEditingController overrideMaxHp;

  @override
  void initState() {
    overrideHP = char.currentHp;
    shouldOverrideMaxHP = char.stats.maxHp != null;
    overrideMaxHp = TextEditingController(text: char.maxHp.toString())
      ..addListener(clampCurrentHP);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const dlgWidth = 400.0;

    return AlertDialog(
      title: Text(tr.hp.dialog.title),
      content: SingleChildScrollView(
        child: CharacterProvider.consumer(
          (context, controller, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: dlgWidth,
                child: HpBar(
                  currentHp: overrideHP,
                  maxHp: maxHP,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: dlgWidth,
                child: SizedBox(
                  width: dlgWidth,
                  child: ValueChangeSlider<int>(
                    value: currentHP,
                    minValue: 0,
                    maxValue: maxHP,
                    updatedValue: overrideHP,
                    onChange: (val) => setState(() => overrideHP = val.round()),
                    positiveText: tr.hp.dialog.change.add,
                    neutralText: (_) => tr.hp.dialog.change.neutral,
                    negativeText: tr.hp.dialog.change.remove,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 32),
              CheckboxListTile(
                value: shouldOverrideMaxHP,
                onChanged: (value) =>
                    setState(() => shouldOverrideMaxHP = value!),
                title: Text(tr.hp.dialog.overrideMax),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                visualDensity: VisualDensity.compact,
              ),
              NumberTextField(
                controller: overrideMaxHp,
                numberType: NumberType.int,
                minValue: 0,
                enabled: shouldOverrideMaxHP,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: DialogControls.save(context,
                    onSave: save, onCancel: close, spacing: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int get currentHP => char.currentHp;
  int get maxHP => shouldOverrideMaxHP
      ? int.tryParse(overrideMaxHp.text) ?? char.defaultMaxHp
      : char.defaultMaxHp;

  ValueChange get change => currentHP == overrideHP
      ? ValueChange.neutral
      : currentHP > overrideHP
          ? ValueChange.negative
          : ValueChange.positive;

  int get changeAmount => (overrideHP - currentHP).abs();

  bool get isChangePositive => change == ValueChange.positive;
  bool get isChangeNegative => change == ValueChange.negative;
  bool get isChangeNeutral => change == ValueChange.neutral;

  clampCurrentHP([dynamic value]) {
    setState(() => overrideHP = min(maxHP, overrideHP));
  }

  void save() {
    charProvider.updateCharacter(
      char.copyWith(
        stats: char.stats
            .copyWith(currentHp: overrideHP)
            .copyWithMaxHp(shouldOverrideMaxHP ? maxHP : null),
      ),
    );
    close();
  }

  void close() async {
    Navigator.of(context).pop();
  }
}
