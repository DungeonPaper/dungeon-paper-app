import 'dart:math';

import 'package:dungeon_paper/app/data/models/character_stats.dart';
import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_panel.dart';
import 'package:dungeon_paper/app/widgets/atoms/xp_bar.dart';
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
  late int overrideXp;
  late bool manualExpExpanded;
  late TextEditingController overrideLevel;
  late bool shouldOverrideLevel;
  late List<SessionMark> eosMarks;

  @override
  void initState() {
    overrideXp = char.currentXp;
    manualExpExpanded = false;
    overrideLevel = TextEditingController(text: char.stats.level.toString());
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
            final level = maxXp - 7;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: dlgWidth,
                  child: ExpBar(
                    currentXp: clamp(overrideXp, 0, maxXp),
                    maxXp: maxXp,
                    pendingXp: totalPendingXp,
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
                        value: currentXp,
                        minValue: 0,
                        maxValue: CharacterStats.maxExpForLevel(level),
                        updatedValue: overrideXp,
                        onChange: (val) => setState(() => overrideXp = val.round()),
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
                        controller: overrideLevel,
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

  int get currentXp => char.currentXp;
  int get maxXp => shouldOverrideLevel
      ? CharacterStats.maxExpForLevel(int.tryParse(overrideLevel.text) ?? char.stats.level)
      : char.maxXp;
  int get eosPendingXp => eosMarks.where((mark) => mark.completed).length;
  int get totalPendingXp => char.pendingXp + eosPendingXp;
  bool get shouldOverrideXp => overrideXp != currentXp;

  // TODO use
  clampCurrentEXP([dynamic value]) {
    setState(() => overrideXp = min(maxXp, overrideXp));
  }

  void save() {
    final beforeLevelXp = (shouldOverrideXp ? overrideXp : char.stats.currentXp + totalPendingXp);
    int updatedLevel = shouldOverrideLevel ? int.parse(overrideLevel.text) : char.stats.level;
    int updatedXp = beforeLevelXp;

    // if xp is over the current level allowance, keep reducing it until it is below the current
    // level while leveling up
    while (updatedXp >= CharacterStats.maxExpForLevel(updatedLevel)) {
      updatedXp -= CharacterStats.maxExpForLevel(updatedLevel);
      updatedLevel++;
    }

    charService.updateCharacter(
      char.copyWith(
        stats: char.stats.copyWith(
          currentXp: updatedXp,
          level: updatedLevel,
        ),
        // reset all session marks completion
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
