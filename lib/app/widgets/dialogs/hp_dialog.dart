import 'dart:math';

import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/hp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/app/widgets/molecules/value_change_slider.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wheel_spinner/wheel_spinner.dart';

enum ValueChange { positive, neutral, negative }

class HPDialog extends StatefulWidget {
  const HPDialog({Key? key}) : super(key: key);

  @override
  State<HPDialog> createState() => _HPDialogState();
}

class _HPDialogState extends State<HPDialog> with CharacterServiceMixin {
  late int overrideHP;
  late bool shouldOverrideMaxHP;
  late TextEditingController overrideMaxHp;

  @override
  void initState() {
    overrideHP = char.currentHp;
    shouldOverrideMaxHP = char.stats.maxHp != null;
    overrideMaxHp = TextEditingController(text: char.maxHp.toString())..addListener(clampCurrentHP);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return AlertDialog(
      title: Text(S.current.hpDialogTitle),
      content: SingleChildScrollView(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HpBar(
                currentHp: overrideHP,
                maxHp: maxHP,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 400,
                child: SizedBox(
                  width: 400,
                  child: ValueChangeSlider<int>(
                    value: currentHP,
                    minValue: 0,
                    maxValue: maxHP,
                    updatedValue: overrideHP,
                    onChange: (val) => setState(() => overrideHP = val.round()),
                    positiveText: S.current.hpDialogChangeAdd,
                    neutralText: (_) => S.current.hpDialogChangeNeutral,
                    negativeText: S.current.hpDialogChangeRemove,
                  ),
                ),
              ),
              ListTile(
                onTap: () => setState(() => shouldOverrideMaxHP = !shouldOverrideMaxHP),
                leading: Checkbox(
                  value: shouldOverrideMaxHP,
                  onChanged: (value) => setState(() => shouldOverrideMaxHP = value!),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 8),
                  child: Text(S.current.hpDialogChangeOverrideMax),
                ),
                subtitle: NumberTextField(
                  controller: overrideMaxHp,
                  numberType: NumberType.int,
                  minValue: 0,
                  enabled: shouldOverrideMaxHP,
                ),
                dense: true,
                visualDensity: VisualDensity.compact,
                minLeadingWidth: 24,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: DialogControls.save(context, onSave: save, onCancel: close, spacing: 8),
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
    charService.updateCharacter(
      char.copyWith(
        stats: char.stats
            .copyWith(currentHp: overrideHP)
            .copyWithMaxHp(shouldOverrideMaxHP ? maxHP : null),
      ),
    );
    close();
  }

  void close() async {
    Get.back();
  }
}
