import 'dart:math';

import 'package:dungeon_paper/app/data/models/character_stats.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_panel.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_tile.dart';
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
  late bool manualExpExpanded;
  late bool manualLevelExpanded;
  late TextEditingController levelOverride;
  late bool shouldOverrideLevel;

  @override
  void initState() {
    overrideExp = char.currentExp;
    manualExpExpanded = false;
    manualLevelExpanded = false;
    levelOverride = TextEditingController(text: char.stats.level.toString());
    shouldOverrideLevel = false;
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
                  height: manualExpExpanded ? 150 : 48,
                  child: CustomExpansionPanel(
                    title: Text(S.current.expDialogChangeOverride),
                    expanded: manualExpExpanded,
                    onExpansion: (value) {
                      setState(() {
                        manualExpExpanded = value;
                      });
                    },
                    children: [
                      ValueChangeSlider<int>(
                        value: currentExp,
                        minValue: 0,
                        maxValue: CharacterStats.maxExpForLevel(level),
                        updatedValue: overrideExp,
                        onChange: (val) => setState(() => overrideExp = val.round()),
                        positiveText: S.current.expDialogChangeAdd,
                        neutralText: (_) => S.current.expDialogChangeNeutral,
                        negativeText: S.current.expDialogChangeRemove,
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 24),
                SizedBox(
                  width: 400,
                  height: manualLevelExpanded ? 150 : 48,
                  child: CustomExpansionPanel(
                    title: Text(S.current.expDialogLevelOverride),
                    expanded: manualLevelExpanded,
                    onExpansion: (value) {
                      setState(() {
                        manualLevelExpanded = value;
                      });
                    },
                    children: [
                      CheckboxListTile(
                        value: shouldOverrideLevel,
                        title: Text(S.current.expDialogLevelShouldOverride),
                        onChanged: (val) => setState(() {
                          shouldOverrideLevel = val!;
                        }),
                      ),
                      NumberTextField(
                        enabled: shouldOverrideLevel,
                        decoration: InputDecoration(label: Text(S.current.level)),
                        numberType: NumberType.int,
                        controller: levelOverride,
                        onChanged: (_) => setState(() {}),
                        minValue: 1,
                      ),
                    ],
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
  int get maxExp => shouldOverrideLevel
      ? CharacterStats.maxExpForLevel(int.tryParse(levelOverride.text) ?? char.stats.level)
      : char.maxExp;

  // TODO use
  clampCurrentEXP([dynamic value]) {
    setState(() => overrideExp = min(maxExp, overrideExp));
  }

  void save() {
    // TODO level up logic
    charService.updateCharacter(
      char.copyWith(
        stats: char.stats.copyWith(
          currentExp: overrideExp,
          level: shouldOverrideLevel ? int.parse(levelOverride.text) : null,
        ),
      ),
    );
    close();
  }

  void close() {
    Get.back();
  }
}
