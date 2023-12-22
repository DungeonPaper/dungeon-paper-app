import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/character_stats.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_tile.dart';
import 'package:dungeon_paper/app/widgets/atoms/xp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/chips/advanced_chip.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

enum _XPAction { endSession, levelUp, overwriteXP }

class EXPDialog extends StatefulWidget {
  const EXPDialog({super.key});

  @override
  State<EXPDialog> createState() => _EXPDialogState();
}

class _EXPDialogState extends State<EXPDialog> with CharacterProviderMixin {
  late TextEditingController overwriteXpText;
  late TextEditingController overwriteLevelText;
  late List<SessionMark> eosMarks;
  bool manualExpExpanded = false;
  bool shouldResetSessionMarks = false;
  int selectedAbilityScoreIndex = 0;
  Move? selectedMove;
  Spell? selectedSpell;

  final endSessionCollapseController = CustomExpansionTileController();
  final levelUpCollapseController = CustomExpansionTileController();
  final overwriteXPCollapseController = CustomExpansionTileController();
  _XPAction action = _XPAction.endSession;
  late CustomExpansionTileController lastActionController;

  // TODO extract to controller
  @override
  void initState() {
    overwriteXpText = TextEditingController(text: char.currentXp.toString())
      ..addListener(() => setState(() {}));
    overwriteLevelText = TextEditingController(text: currentLevel.toString())
      ..addListener(() => setState(() {}));
    eosMarks = char.endOfSessionMarks;
    lastActionController = endSessionCollapseController;
    // Calculate the maximum stat, to be selected by default for leveling up. Must handle custom stats on the sheet.
    num maxStat = double.negativeInfinity;
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
    overwriteLevelText.dispose();
    overwriteXpText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const dialogWidth = 400.0;
    final showPendingXp = !shouldResetSessionMarks ||
        (!shouldOverwriteXp && !shouldOverwriteLevel);
    final cls = char.characterClass;
    return AlertDialog(
      title: Text(action.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: dialogWidth,
              child: ExpBar(
                currentXp: int.tryParse(overwriteXpText.text) ?? currentXp,
                maxXp: maxXp,
                pendingXp: showPendingXp ? totalPendingXp : 0,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: dialogWidth,
                height: action == _XPAction.endSession
                    ? (PlatformHelper.isMobile ? 364 : 332)
                    : 48,
                child: CustomExpansionTile(
                  title: Text(tr.xp.dialog.endOfSession.title),
                  initiallyExpanded: true,
                  controller: endSessionCollapseController,
                  expandable: action != _XPAction.endSession,
                  onExpansionChanged: (value) {
                    if (!value) return;
                    setState(() {
                      lastActionController.collapse();
                      action = _XPAction.endSession;
                      lastActionController = endSessionCollapseController;
                    });
                    return;
                  },
                  children: [
                    SizedBox(
                      width: dialogWidth,
                      child: ListTile(
                        title: Text(tr.xp.dialog.endOfSession.questions.title),
                        subtitle:
                            Text(tr.xp.dialog.endOfSession.questions.subtitle),
                      ),
                    ),
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
                  ],
                )),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: dialogWidth,
              height: action == _XPAction.levelUp
                  ? (PlatformHelper.isMobile ? 400 : 332)
                  : 48,
              child: CustomExpansionTile(
                title: Text(tr.xp.dialog.levelUp.title),
                controller: levelUpCollapseController,
                expandable: action != _XPAction.levelUp,
                onExpansionChanged: (value) {
                  if (!value) return;
                  setState(() {
                    lastActionController.collapse();
                    action = _XPAction.levelUp;
                    lastActionController = levelUpCollapseController;
                  });
                  return;
                },
                children: [
                  Text(tr.xp.dialog.levelUp.increaseStat),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 380),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: List.generate(
                            char.abilityScores.stats.length,
                            (i) {
                              final stat = char.abilityScores.stats[i];
                              final selected = selectedAbilityScoreIndex == i;
                              final foregroundColor = selected
                                  ? Theme.of(context).colorScheme.onSurface
                                  : null;
                              final backgroundColor = selected
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                  : null;
                              return SizedBox(
                                width: constraints.maxWidth / 3 - 8,
                                child: AdvancedChip(
                                  visualDensity: VisualDensity.comfortable,
                                  label: Text(
                                    '${stat.key} ${stat.value}',
                                    style: TextStyle(color: foregroundColor),
                                  ),
                                  avatar:
                                      Icon(stat.icon, color: foregroundColor),
                                  // selected: selected,
                                  backgroundColor: backgroundColor,
                                  // isEnabled: selectedAbilityScoreIndex == i,
                                  onPressed: stat.value < 18
                                      ? () => setState(() {
                                            selectedAbilityScoreIndex = i;
                                          })
                                      : null,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    tr.xp.dialog.levelUp.choose.info(
                      cls.isSpellcaster
                          ? tr.xp.dialog.levelUp.choose.both(
                              tr.xp.dialog.levelUp.choose.move,
                              tr.xp.dialog.levelUp.choose.spell,
                            )
                          : tr.xp.dialog.levelUp.choose.move,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    title: Text(
                      tr.generic.selectEntity(tr.xp.dialog.levelUp.choose.move),
                    ),
                    subtitle: Text(
                      selectedMove?.name ??
                          tr.generic.noEntitySelected(tr.entity(tn(Move))),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    trailing: ElevatedButton(
                      child: Text(
                        selectedMove == null
                            ? tr.generic.selectEntity(tr.entity(tn(Move)))
                            : tr.generic.changeEntity(tr.entity(tn(Move))),
                      ),
                      onPressed: () => ModelPages.openMovesList(
                        context,
                        category: currentLevel + 1 >= 6
                            ? MoveCategory.advanced2
                            : MoveCategory.advanced1,
                        character: char,
                        classKeys: [cls.reference],
                        onSelected: (move) => setState(
                          () {
                            selectedMove = move.single;
                          },
                        ),
                      ),
                    ),
                  ),
                  if (cls.isSpellcaster)
                    ListTile(
                      title: Text(
                        tr.generic
                            .selectEntity(tr.xp.dialog.levelUp.choose.spell),
                      ),
                      subtitle: Text(
                        selectedSpell?.name ??
                            tr.generic.noEntitySelected(tr.entity(tn(Spell))),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      trailing: ElevatedButton(
                        child: Text(
                          selectedSpell == null
                              ? tr.generic.selectEntity(tr.entity(tn(Spell)))
                              : tr.generic.changeEntity(tr.entity(tn(Spell))),
                        ),
                        onPressed: () => ModelPages.openSpellsList(
                          context,
                          character: char,
                          classKeys: [char.characterClass.reference],
                          onSelected: (move) => setState(
                            () {
                              selectedSpell = move.single;
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: dialogWidth,
              height: action == _XPAction.overwriteXP
                  ? (PlatformHelper.isMobile ? 364 : 332)
                  : 48,
              child: CustomExpansionTile(
                title: Text(
                    tr.xp.dialog.overwrite.title + (hasOverwrites ? '*' : '')),
                controller: overwriteXPCollapseController,
                expandable: action != _XPAction.overwriteXP,
                onExpansionChanged: (value) {
                  if (!value) return;
                  setState(() {
                    lastActionController.collapse();
                    action = _XPAction.overwriteXP;
                    lastActionController = overwriteXPCollapseController;
                  });
                  return;
                },
                children: [
                  CheckboxListTile(
                    value: shouldResetSessionMarks,
                    onChanged: (val) => setState(
                      () => shouldResetSessionMarks = val!,
                    ),
                    title: Text(tr.xp.dialog.overwrite.resetCheckbox),
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const Divider(height: 32),
                  NumberTextField(
                    controller: overwriteXpText,
                    numberType: NumberType.int,
                    decoration: InputDecoration(
                      labelText: tr.xp.dialog.overwrite.xp +
                          (shouldOverwriteXp ? '*' : ''),
                    ),
                    minValue: 0,
                  ),
                  const SizedBox(height: 16),
                  NumberTextField(
                    decoration: InputDecoration(
                      labelText: tr.xp.dialog.overwrite.level +
                          (shouldOverwriteLevel ? '*' : ''),
                    ),
                    numberType: NumberType.int,
                    controller: overwriteLevelText,
                    minValue: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: DialogControls.save(
                context,
                onSave: (action == _XPAction.endSession)
                    ? endSession
                    : (action == _XPAction.overwriteXP)
                        ? overwriteXpAndLevel
                        : (action == _XPAction.levelUp && canLevelUp)
                            ? levelUp
                            : null,
                saveLabel: action.saveButton,
                onCancel: close,
                spacing: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int get currentXp => char.currentXp;
  int get currentLevel => char.stats.level;
  int get maxXp => shouldOverwriteLevel
      ? CharacterStats.maxExpForLevel(
          int.tryParse(overwriteLevelText.text) ?? currentLevel)
      : char.maxXp;
  int get totalPendingXp =>
      char.sessionMarks.where((mark) => mark.completed).length;
  bool get canLevelUp => currentXp - currentLevel - 7 >= 0;

  bool get shouldOverwriteXp =>
      int.tryParse(overwriteXpText.text) != null &&
      int.parse(overwriteXpText.text) != currentXp;
  bool get shouldOverwriteLevel =>
      int.tryParse(overwriteLevelText.text) != null &&
      int.parse(overwriteLevelText.text) != currentLevel;
  bool get hasOverwrites =>
      shouldOverwriteLevel || shouldOverwriteXp || shouldResetSessionMarks;

  void endSession() {
    save(currentXp + totalPendingXp, currentLevel, resetSession: true);
  }

  void levelUp() {
    if (!canLevelUp) return;
    save(
      currentXp - currentLevel - 7,
      currentLevel + 1,
      abilityScoreToIncrease:
          char.abilityScores.stats[selectedAbilityScoreIndex],
      move: selectedMove,
      spell: selectedSpell,
    );
  }

  void overwriteXpAndLevel() {
    save(
      int.tryParse(overwriteXpText.text) ?? 0,
      int.tryParse(overwriteLevelText.text) ?? currentLevel,
      resetSession: shouldResetSessionMarks,
    );
  }

  void save(
    int xp,
    int level, {
    bool resetSession = false,
    AbilityScore? abilityScoreToIncrease,
    Move? move,
    Spell? spell,
  }) {
    AbilityScores? abilityScores;
    if (abilityScoreToIncrease != null) {
      abilityScores = char.abilityScores.copyWithStatValues(
          {abilityScoreToIncrease.key: abilityScoreToIncrease.value + 1});
    }
    charProvider.updateCharacter(
      char.copyWith(
        abilityScores: abilityScores,
        stats: char.stats.copyWith(
          currentXp: xp,
          level: level,
        ),
        sessionMarks: (resetSession)
            ? char.sessionMarks
                .map((e) => e.copyWithInherited(completed: false))
                .toList()
            : upsertByKey(char.sessionMarks, eosMarks),
        moves: move != null ? upsertByKey(char.moves, [move]) : null,
        spells: spell != null ? upsertByKey(char.spells, [spell]) : null,
      ),
    );

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

extension on _XPAction {
  String get title {
    switch (this) {
      case _XPAction.endSession:
        return tr.xp.dialog.endOfSession.title;
      case _XPAction.levelUp:
        return tr.xp.dialog.levelUp.title;
      case _XPAction.overwriteXP:
        return tr.xp.dialog.overwrite.title;
    }
  }

  String get saveButton {
    switch (this) {
      case _XPAction.endSession:
        return tr.xp.dialog.endOfSession.button;
      case _XPAction.levelUp:
        return tr.xp.dialog.levelUp.button;
      case _XPAction.overwriteXP:
        return tr.xp.dialog.overwrite.button;
    }
  }
}

