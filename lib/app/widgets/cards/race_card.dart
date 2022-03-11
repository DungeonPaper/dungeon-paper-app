import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/app/widgets/chips/move_category_chip.dart';
import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:flutter/material.dart';

import '../../data/models/move.dart';
import 'dynamic_action_card.dart';

class RaceCard extends StatelessWidget {
  const RaceCard({
    Key? key,
    required this.race,
    this.showStar = true,
  }) : super(key: key);

  final Race race;
  final bool showStar;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: race.name,
      children: [Text(race.description)],
      chips: race.tags.map((t) => TagChip(tag: t)),
      dice: [],
      icon: SvgIcon(race.icon, size: 16),
      starred: race.favorited,
      showStar: showStar,
    );
  }
}
