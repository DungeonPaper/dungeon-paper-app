import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:flutter/material.dart';

import 'dynamic_action_card.dart';

class RaceCard extends StatelessWidget {
  const RaceCard({
    Key? key,
    required this.race,
    this.showStar = true,
    this.showIcon = true,
    this.initiallyExpanded = false,
    this.expansionKey,
  }) : super(key: key);

  final Race race;
  final bool showStar;
  final bool showIcon;
  final bool initiallyExpanded;
  final PageStorageKey? expansionKey;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: race.name,
      description: race.description,
      explanation: race.explanation,
      chips: race.tags.map((t) => TagChip(tag: t)),
      dice: const [],
      icon: showIcon ? SvgIcon(race.icon, size: 16) : null,
      starred: race.favorited,
      showStar: showStar,
      onStarChanged: (favorited) => null,
      initiallyExpanded: initiallyExpanded,
      expansionKey: expansionKey ?? PageStorageKey(race.key),
    );
  }
}
