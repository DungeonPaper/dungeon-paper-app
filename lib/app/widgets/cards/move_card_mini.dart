import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/widgets/chips/move_category_chip.dart';
import 'package:flutter/material.dart';

import '../../data/models/move.dart';
import 'dynamic_action_card_mini.dart';

class MoveCardMini extends StatelessWidget {
  const MoveCardMini({
    Key? key,
    required this.move,
    this.onSave,
    this.showStar = true,
    this.showIcon = true,
    this.onTap,
    this.advancedLevelDisplay = AdvancedLevelDisplay.short,
    this.abilityScores,
  }) : super(key: key);

  final Move move;
  final bool showStar;
  final bool showIcon;
  final void Function(Move move)? onSave;
  final void Function()? onTap;
  final AdvancedLevelDisplay advancedLevelDisplay;
  final AbilityScores? abilityScores;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCardMini(
      title: move.name,
      description: move.description,
      chips: [
        MoveCategoryChip(
          category: move.category,
          advancedLevelDisplay: advancedLevelDisplay,
        ),
      ],
      dice: move.dice,
      icon: showIcon ? Icon(move.icon, size: 16) : null,
      starred: move.favorite,
      showStar: showStar,
      onStarChanged: (favorite) =>
          onSave?.call(move.copyWithInherited(favorite: favorite)),
      onTap: onTap,
      abilityScores: abilityScores,
    );
  }
}
