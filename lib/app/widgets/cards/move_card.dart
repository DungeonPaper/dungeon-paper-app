import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/widgets/chips/move_category_chip.dart';
import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';

import '../../data/models/move.dart';
import 'dynamic_action_card.dart';

class MoveCard extends StatelessWidget {
  const MoveCard({
    super.key,
    required this.move,
    this.onSave,
    this.showDice = true,
    this.showStar = true,
    this.showIcon = true,
    this.showClasses = false,
    this.initiallyExpanded,
    this.actions = const [],
    this.expansionKey,
    this.maxContentHeight,
    this.expandable = true,
    this.advancedLevelDisplay = AdvancedLevelDisplay.short,
    this.highlightWords = const [],
    this.abilityScores,
    this.reorderablePadding = false,
    this.leading = const [],
    this.trailing = const [],
  });

  final Move move;
  final void Function(Move move)? onSave;
  final bool showDice;
  final bool showStar;
  final bool showIcon;
  final bool showClasses;
  final bool? initiallyExpanded;
  final Iterable<Widget> actions;
  final PageStorageKey? expansionKey;
  final double? maxContentHeight;
  final bool expandable;
  final AdvancedLevelDisplay advancedLevelDisplay;
  final List<String> highlightWords;
  final AbilityScores? abilityScores;
  final bool reorderablePadding;
  final List<Widget> leading;
  final List<Widget> trailing;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: move.name,
      description: move.description,
      explanation: move.explanation,
      maxContentHeight: maxContentHeight,
      expandable: expandable,
      reorderablePadding: reorderablePadding,
      expansionKey: expansionKey ?? PageStorageKey(move.key),
      chips: move.tags.map((t) => TagChip.openDescription(context, tag: t)),
      dice: showDice ? move.dice : [],
      icon: showIcon ? Icon(move.icon, size: 16) : null,
      starred: move.favorite,
      showStar: showStar,
      onStarChanged: (favorite) =>
          onSave?.call(move.copyWithInherited(favorite: favorite)),
      initiallyExpanded: initiallyExpanded,
      actions: actions,
      highlightWords: highlightWords,
      leading: [
        ...leading,
        MoveCategoryChip(
          category: move.category,
          advancedLevelDisplay: advancedLevelDisplay,
        ),
        ...trailing,
      ].joinObjects(const SizedBox(width: 8)),
      abilityScores: abilityScores,
    );
  }
}
