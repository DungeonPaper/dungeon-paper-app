import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/character_stats.dart';
import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_tile.dart';
import 'package:dungeon_paper/app/widgets/atoms/help_text.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/app/widgets/atoms/xp_bar.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum _XPAction { endSession, levelUp, overwriteXP }

class EXPDialog extends StatefulWidget {
  const EXPDialog({super.key});

  @override
  State<EXPDialog> createState() => _EXPDialogState();
}

class _EXPDialogState extends State<EXPDialog> with CharacterServiceMixin {
  late TextEditingController overwriteXp;
  late TextEditingController overwriteLevel;
  late List<SessionMark> eosMarks;
  bool manualExpExpanded = false;
  bool shouldResetSessionMarks = false;
  int selectedAbilityScoreIndex = 0;

  final endSessionCollapseController = CustomExpansionTileController();
  final levelUpCollapseController = CustomExpansionTileController();
  final overwriteXPCollapseController = CustomExpansionTileController();
  _XPAction action = _XPAction.endSession;
  late CustomExpansionTileController lastActionController;

  @override
  void initState() {
    overwriteXp = TextEditingController(text: char.currentXp.toString())..addListener(() => setState(() {}));
    overwriteLevel = TextEditingController(text: currentLevel.toString())..addListener(() => setState(() {}));
    eosMarks = char.endOfSessionMarks;
    lastActionController = endSessionCollapseController;
    // Calculate the maximum stat, to be selected by default for leveling up. Must handle custom stats on the sheet.
    var maxStat = -2147483648; // Lazy way to avoid dealing with max/min, if the first stat was 18 for example
    for (var i = 0; i < char.abilityScores.stats.length; i += 1) {
      final statValue = char.abilityScores.stats[i].value;
      if (statValue > maxStat && statValue < 18) {
        selectedAbilityScoreIndex = i;
        maxStat = statValue;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    overwriteLevel.dispose();
    overwriteXp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const dialogWidth = 400.0;

    return AlertDialog(
      title: Text(action.title),
      content: SingleChildScrollView(
        child: Obx(
          () {
            final level = maxXp - 7;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: dialogWidth,
                  child: ExpBar(
                    currentXp: clamp(
                        int.tryParse(overwriteXp.text) ?? currentXp, 0, maxXp),
                    maxXp: maxXp,
                    pendingXp: !shouldResetSessionMarks ||
                            (!shouldOverrideXp && !shouldOverrideLevel)
                        ? totalPendingXp
                        : 0,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: dialogWidth,
                  child: ListTile(
                    title: Text(
                      tr.xp.dialog.endOfSession.questions.title,
                    ),
                    subtitle: Text(
                      tr.xp.dialog.endOfSession.questions.subtitle,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                for (final eos in eosMarks)
                  SizedBox(
                    width: dialogWidth,
                    child: CheckboxListTile(
                      value: eos.completed,
                      title: Text(eos.description),
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      onChanged: (val) => _toggleEosMark(eos, val),
                    ),
                  ),
                const SizedBox(height: 24),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: dialogWidth,
                  height: manualExpExpanded
                      ? (332 +
                          (PlatformHelper.isIOS || PlatformHelper.isAndroid
                              ? 32
                              : 0))
                      : 48,
                  child: CustomExpansionPanel(
                    title: Text(
                      tr.xp.dialog.override.title + (hasOverrides ? '*' : ''),
                    ),
                    expanded: manualExpExpanded,
                    onExpansion: (value) {
                      setState(() {
                        manualExpExpanded = value;
                      });
                    },
                    children: [
                      HelpText(text: tr.xp.dialog.override.info),
                      const SizedBox(height: 8),
                      CheckboxListTile(
                        value: shouldResetSessionMarks,
                        onChanged: (val) => setState(
                          () => shouldResetSessionMarks =
                              val ?? !shouldResetSessionMarks,
                        ),
                        title: Text(tr.xp.dialog.override.resetCheckbox),
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      const Divider(height: 32),
                      NumberTextField(
                        controller: overwriteXp,
                        numberType: NumberType.int,
                        decoration: InputDecoration(
                          labelText: tr.xp.dialog.override.xp +
                              (shouldOverrideXp ? '*' : ''),
                        ),
                        minValue: 0,
                        maxValue: CharacterStats.maxExpForLevel(level),
                      ),
                      const SizedBox(height: 16),
                      NumberTextField(
                        decoration: InputDecoration(
                          labelText: tr.xp.dialog.override.level +
                              (shouldOverrideLevel ? '*' : ''),
                        ),
                        numberType: NumberType.int,
                        controller: overwriteLevel,
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
                    saveLabel: shouldResetSessionMarks
                        ? tr.xp.dialog.endOfSession.button
                        : null,
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
  int get currentLevel => char.stats.level;
  int get maxXp => shouldOverrideLevel
      ? CharacterStats.maxExpForLevel(
          int.tryParse(overwriteLevel.text) ?? currentLevel)
      : char.maxXp;
  int get eosPendingXp => eosMarks.where((mark) => mark.completed).length;
  int get totalPendingXp =>
      char.sessionMarks
          .where((mark) =>
              mark.type != dw.SessionMarkType.endOfSession && mark.completed)
          .length +
      eosPendingXp;
  int get effectiveXp =>
      shouldOverrideXp ? int.parse(overwriteXp.text) : currentXp;
  int get effectiveLevel =>
      shouldOverrideLevel ? int.parse(overwriteLevel.text) : currentLevel;
  bool get shouldOverrideXp =>
      int.tryParse(overwriteXp.text) != null &&
      int.parse(overwriteXp.text) != currentXp;

  bool get shouldOverrideLevel =>
      int.tryParse(overwriteLevel.text) != null &&
      int.parse(overwriteLevel.text) != currentLevel;

  bool get hasOverrides =>
      shouldOverrideLevel || shouldOverrideXp || !shouldResetSessionMarks;

  void save() {
    final beforeLevelXp =
        effectiveXp + (shouldResetSessionMarks ? totalPendingXp : 0);
    int updatedLevel = effectiveLevel;
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
        sessionMarks: shouldResetSessionMarks
            ? char.sessionMarks
                .map((e) => e.copyWithInherited(completed: false))
                .toList()
            : upsertByKey(char.sessionMarks, eosMarks),
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
      eosMarks = updateByKey(
          eosMarks, [eos.copyWithInherited(completed: val ?? !eos.completed)]);
      charService.updateCharacter(char.copyWith(
          sessionMarks: upsertByKey(char.sessionMarks, eosMarks)));
    });
  }
}
