import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:flutter/material.dart';

import '../../data/models/race.dart';
import 'dynamic_action_card_mini.dart';

class RaceCardMini extends StatelessWidget {
  const RaceCardMini({
    Key? key,
    required this.race,
    this.onSave,
    this.showStar = true,
    this.showIcon = true,
    this.onTap,
  }) : super(key: key);

  final Race race;
  final bool showStar;
  final bool showIcon;
  final void Function(Race race)? onSave;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCardMini(
      title: race.name,
      description: race.description,
      chips: const [],
      dice: const [],
      icon: showIcon ? Icon(race.icon, size: 16) : null,
      starred: race.favorited,
      showStar: showStar,
      onStarChanged: (favorited) => onSave?.call(race.copyWithInherited(favorited: favorited)),
      onTap: onTap,
    );
  }
}
