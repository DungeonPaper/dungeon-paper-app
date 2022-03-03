import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/app/widgets/chips/move_category_chip.dart';
import 'package:flutter/material.dart';

import '../../data/models/move.dart';
import 'dynamic_action_card_mini.dart';

class MoveCardMini extends StatelessWidget {
  const MoveCardMini({
    Key? key,
    required this.move,
    this.showDice = true,
    this.showStar = true,
  }) : super(key: key);

  final Move move;
  final bool showDice;
  final bool showStar;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCardMini(
      title: move.name,
      description: move.description,
      chips: [MoveCategoryChip(category: move.category)],
      dice: showDice ? move.dice : [],
      icon: SvgIcon(move.icon, size: 16),
      starred: move.favorited,
      showStar: showStar,
    );
  }
}
