import 'package:dungeon_paper/app/data/models/character_stats.dart';
import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_panel.dart';
import 'package:dungeon_paper/app/widgets/atoms/help_text.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/atoms/xp_bar.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ValueChange { positive, neutral, negative }

class EXPDialog extends StatefulWidget {
  const EXPDialog({super.key});

  @override
  State<EXPDialog> createState() => _EXPDialogState();
}

class _EXPDialogState extends State<EXPDialog> with CharacterProviderMixin {
  late TextEditingController overrideXp;
  late bool manualExpExpanded;
  late TextEditingController overrideLevel;
  late bool shouldResetSessionMarks;
  late List<SessionMark> eosMarks;

  @override
  void initState() {
    overrideXp = TextEditingController(text: char.currentXp.toString())
      ..addListener(() => setState(() {}));
    manualExpExpanded = false;
    overrideLevel = TextEditingController(text: currentLevel.toString())
      ..addListener(() => setState(() {}));
    shouldResetSessionMarks = true;
    eosMarks = char.endOfSessionMarks;
    super.initState();
  }

  @override
  void dispose() {
    overrideLevel.dispose();
    overrideXp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const dlgWidth = 400.0;

    return AlertDialog(
      title: Text(
          !hasOverrides ? tr.xp.dialog.title : tr.xp.dialog.overridingTitle),
      content: SingleChildScrollView(
        child: Consumer<CharacterProvider>(
          builder: (context, charProvider, child) {
            final level = maxXp - 7;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: dlgWidth,
                  child: ExpBar(
                    currentXp: clamp(
                        int.tryParse(overrideXp.text) ?? currentXp, 0, maxXp),
                    maxXp: maxXp,
                    pendingXp: !shouldResetSessionMarks ||
                            (!shouldOverrideXp && !shouldOverrideLevel)
                        ? totalPendingXp
                        : 0,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: dlgWidth,
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
                    width: dlgWidth,
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
                  width: dlgWidth,
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
                        controller: overrideXp,
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
          int.tryParse(overrideLevel.text) ?? currentLevel)
      : char.maxXp;
  int get eosPendingXp => eosMarks.where((mark) => mark.completed).length;
  int get totalPendingXp =>
      char.sessionMarks
          .where((mark) =>
              mark.type != dw.SessionMarkType.endOfSession && mark.completed)
          .length +
      eosPendingXp;
  int get effectiveXp =>
      shouldOverrideXp ? int.parse(overrideXp.text) : currentXp;
  int get effectiveLevel =>
      shouldOverrideLevel ? int.parse(overrideLevel.text) : currentLevel;
  bool get shouldOverrideXp =>
      int.tryParse(overrideXp.text) != null &&
      int.parse(overrideXp.text) != currentXp;

  bool get shouldOverrideLevel =>
      int.tryParse(overrideLevel.text) != null &&
      int.parse(overrideLevel.text) != currentLevel;

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

    charProvider.updateCharacter(
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
    Navigator.of(context).pop();
  }

  void _toggleEosMark(SessionMark eos, bool? val) {
    setState(() {
      eosMarks = updateByKey(
          eosMarks, [eos.copyWithInherited(completed: val ?? !eos.completed)]);
      charProvider.updateCharacter(char.copyWith(
          sessionMarks: upsertByKey(char.sessionMarks, eosMarks)));
    });
  }
}
