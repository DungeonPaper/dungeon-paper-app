import 'package:dungeon_paper/app/widgets/chips/character_class_chip.dart';
import 'package:dungeon_paper/app/widgets/chips/move_category_chip.dart';
import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';

import '../../data/models/race.dart';
import 'dynamic_action_card.dart';

class RaceCard extends StatelessWidget {
  const RaceCard({
    super.key,
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
    this.showClasses = false,
    this.leading = const [],
    this.trailing = const [],
  });

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
  final bool showClasses;
  final List<Widget> leading;
  final List<Widget> trailing;

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
      starred: race.favorite,
      showStar: showStar,
      onStarChanged: (favorite) =>
          onSave?.call(race.copyWithInherited(favorite: favorite)),
      initiallyExpanded: initiallyExpanded,
      actions: actions,
      highlightWords: highlightWords,
      leading: [
        ...leading,
        if (showClasses)
          for (final cls in race.classKeys) ...[
            CharacterClassChip(characterClass: cls),
          ],
        if (trailing.isNotEmpty) const SizedBox(width: 8),
        ...trailing,
      ].joinObjects(const SizedBox(width: 8)),
    );
  }
}

