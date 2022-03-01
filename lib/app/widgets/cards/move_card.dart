import 'package:dungeon_paper/app/widgets/chips/move_category_chip.dart';
import 'package:flutter/material.dart';

import '../../data/models/move.dart';
import 'dynamic_action_card.dart';

class MoveCard extends StatelessWidget {
  const MoveCard({
    Key? key,
    required this.move,
    this.showDice = true,
  }) : super(key: key);

  final Move move;
  final bool showDice;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: move.name,
      body: [Text(move.description)],
      chips: [MoveCategoryChip(category: move.category)],
      dice: showDice ? move.dice : [],
      icon: move.icon,
      starred: move.favorited,
    );
  }
}
