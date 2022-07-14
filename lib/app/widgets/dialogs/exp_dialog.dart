import 'dart:math';

import 'package:dungeon_paper/app/data/models/character_stats.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/exp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/hp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/app/widgets/molecules/value_change_slider.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wheel_spinner/wheel_spinner.dart';

enum ValueChange { positive, neutral, negative }

class EXPDialog extends StatefulWidget {
  const EXPDialog({Key? key}) : super(key: key);

  @override
  State<EXPDialog> createState() => _EXPDialogState();
}

class _EXPDialogState extends State<EXPDialog> with CharacterServiceMixin {
  late int overrideExp;

  @override
  void initState() {
    overrideExp = char.currentExp;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    // debugPrint('total max exp for level 1: ${CharacterStats.totalMaxExpForLevel(1)}\n\n'
    //     'total max exp for level 2: ${CharacterStats.totalMaxExpForLevel(2)}\n\n'
    //     'total max exp for level 3: ${CharacterStats.totalMaxExpForLevel(3)}\n\n'
    //     'total max exp for level 4: ${CharacterStats.totalMaxExpForLevel(4)}\n\n'
    //     'total max exp for level 5: ${CharacterStats.totalMaxExpForLevel(5)}');

    return AlertDialog(
      title: Text(S.current.expDialogTitle),
      content: SingleChildScrollView(
        child: Obx(
          () {
            var level = maxExp - 7;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 400,
                  child: ExpBar(
                    currentExp: clamp(overrideExp, 0, maxExp),
                    maxExp: maxExp,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 400,
                  child: ValueChangeSlider<int>(
                    value: currentExp,
                    minValue: level > 1 ? -CharacterStats.totalMaxExpForLevel(level - 1) : 0,
                    updatedValue: overrideExp,
                    onChange: (val) => setState(() => overrideExp = val.round()),
                    positiveText: S.current.expDialogChangeAdd,
                    neutralText: (_) => S.current.expDialogChangeNeutral,
                    negativeText: S.current.expDialogChangeRemove,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: DialogControls.save(context, onSave: save, onCancel: close, spacing: 8),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  int get currentExp => char.currentExp;
  int get maxExp => char.maxExp;

  ValueChange get change => currentExp == overrideExp
      ? ValueChange.neutral
      : currentExp > overrideExp
          ? ValueChange.negative
          : ValueChange.positive;

  int get changeAmount => (overrideExp - currentExp).abs();

  bool get isChangePositive => change == ValueChange.positive;
  bool get isChangeNegative => change == ValueChange.negative;
  bool get isChangeNeutral => change == ValueChange.neutral;

  clampCurrentEXP([dynamic value]) {
    setState(() => overrideExp = min(maxExp, overrideExp));
  }

  void save() {
    // TODO level up logic
    charService.updateCharacter(
      char.copyWith(stats: char.stats.copyWith(currentExp: overrideExp)),
    );
    close();
  }

  void close() async {
    Get.back();
  }
}
