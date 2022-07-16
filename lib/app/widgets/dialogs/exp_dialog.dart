import 'dart:math';

import 'package:dungeon_paper/app/data/models/character_stats.dart';
import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_panel.dart';
import 'package:dungeon_paper/app/widgets/atoms/exp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/app/widgets/molecules/value_change_slider.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

enum ValueChange { positive, neutral, negative }

class EXPDialog extends StatefulWidget {
  const EXPDialog({Key? key}) : super(key: key);

  @override
  State<EXPDialog> createState() => _EXPDialogState();
}

class _EXPDialogState extends State<EXPDialog> with CharacterServiceMixin {
  late int overrideExp;
  late bool manualExpExpanded;
  late TextEditingController levelOverride;
  late bool shouldOverrideLevel;
  late List<SessionMark> eosMarks;

  @override
  void initState() {
    overrideExp = char.currentExp;
    manualExpExpanded = false;
    levelOverride = TextEditingController(text: char.stats.level.toString());
    shouldOverrideLevel = false;
    eosMarks = char.endOfSessionMarks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const dlgWidth = 400.0;

    return AlertDialog(
      title: Text(S.current.expDialogTitle),
      content: SingleChildScrollView(
        child: Obx(
          () {
            final level = maxExp - 7;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: dlgWidth,
                  child: ExpBar(
                    currentExp: clamp(overrideExp, 0, maxExp),
                    maxExp: maxExp,
                    pendingExp: totalPendingExp,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: dlgWidth,
                  child: ListTile(
                    title: Text(
                      S.current.endOfSessionQuestions,
                    ),
                    subtitle: Text(
                      S.current.endOfSessionQuestionsSubtitle,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                for (final eos in eosMarks)
                  SizedBox(
                    width: dlgWidth,
                    child: CheckboxListTile(
                      value: eos.completed,
                      dense: true,
                      title: Text(eos.description),
                      onChanged: (val) => _toggleEosMark(eos, val),
                    ),
                  ),
                const SizedBox(height: 24),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: dlgWidth,
                  height: manualExpExpanded ? 312 : 48,
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
                      const SizedBox(height: 16),
                      const Divider(height: 24),
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
                // const SizedBox(height: 24),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: DialogControls.save(
                    context,
                    onSave: save,
                    saveLabel: S.current.expDialogEndSession,
                    onCancel: close,
                    spacing: 8,
                  ),
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
  int get eosPendingExp => eosMarks.where((mark) => mark.completed).length;
  int get totalPendingExp => char.pendingExp + eosPendingExp;
  bool get shouldOverrideExp => overrideExp != currentExp;

  // TODO use
  clampCurrentEXP([dynamic value]) {
    setState(() => overrideExp = min(maxExp, overrideExp));
  }

  void save() {
    final beforeLevelExp = char.stats.currentExp + totalPendingExp;
    int updatedLevel = char.stats.level;
    int updatedExp = beforeLevelExp;

    while (updatedExp >= CharacterStats.maxExpForLevel(updatedLevel)) {
      updatedExp = beforeLevelExp - CharacterStats.maxExpForLevel(updatedLevel);
      updatedLevel++;
    }

    final finalExp = shouldOverrideExp ? overrideExp : updatedExp;
    final finalLevel =
        shouldOverrideLevel ? int.tryParse(levelOverride.text) ?? updatedLevel : updatedLevel;

    charService.updateCharacter(
      char.copyWith(
        stats: char.stats.copyWith(
          currentExp: finalExp,
          level:
              finalExp >= CharacterStats.maxExpForLevel(finalLevel) ? finalLevel + 1 : finalLevel,
        ),
        sessionMarks: char.sessionMarks.map((e) => e.copyWithInherited(completed: false)).toList(),
      ),
    );

    // TODO pop-up level up dialog if needed

    close();
  }

  void close() {
    Get.back();
  }

  void _toggleEosMark(SessionMark eos, bool? val) {
    setState(() {
      eosMarks = updateByKey(eosMarks, [eos.copyWithInherited(completed: val ?? !eos.completed)]);
    });
  }
}
