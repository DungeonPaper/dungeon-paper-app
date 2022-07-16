import 'package:dungeon_paper/app/widgets/chips/move_category_chip.dart';
import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:flutter/material.dart';

import '../../data/models/race.dart';
import 'dynamic_action_card.dart';

class RaceCard extends StatelessWidget {
  const RaceCard({
    Key? key,
    required this.race,
    this.onSave,
    this.showStar = true,
    this.showIcon = true,
    this.initiallyExpanded,
    this.actions = const [],
    this.expansionKey,
    this.maxContentHeight,
    this.expandable = true,
    this.advancedLevelDisplay = AdvancedLevelDisplay.short,
    this.highlightWords = const [],
  }) : super(key: key);

  final Race race;
  final void Function(Race race)? onSave;
  final bool showStar;
  final bool showIcon;
  final bool? initiallyExpanded;
  final Iterable<Widget> actions;
  final PageStorageKey? expansionKey;
  final double? maxContentHeight;
  final bool expandable;
  final AdvancedLevelDisplay advancedLevelDisplay;
  final List<String> highlightWords;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: race.name,
      description: race.description,
      explanation: race.explanation,
      maxContentHeight: maxContentHeight,
      expandable: expandable,
      expansionKey: expansionKey ?? PageStorageKey(race.key),
      chips: race.tags.map((t) => TagChip.openDescription(tag: t)),
      dice: const [],
      icon: showIcon ? Icon(race.icon, size: 16) : null,
      starred: race.favorited,
      showStar: showStar,
      onStarChanged: (favorited) => onSave?.call(race.copyWithInherited(favorited: favorited)),
      initiallyExpanded: initiallyExpanded,
      actions: actions,
      highlightWords: highlightWords,
      leading: const [],
    );
  }
}
