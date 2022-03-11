import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/app/widgets/chips/move_category_chip.dart';
import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:flutter/material.dart';

import '../../data/models/move.dart';
import 'dynamic_action_card.dart';

class MoveCard extends StatelessWidget {
  const MoveCard({
    Key? key,
    required this.move,
    this.onSave,
    this.showDice = true,
    this.showStar = true,
  }) : super(key: key);

  final Move move;
  final void Function(Move move)? onSave;
  final bool showDice;
  final bool showStar;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: move.name,
      children: [Text(move.description)],
      chips: [MoveCategoryChip(category: move.category), ...move.tags.map((t) => TagChip(tag: t))],
      dice: showDice ? move.dice : [],
      icon: SvgIcon(move.icon, size: 16),
      starred: move.favorited,
      showStar: showStar,
      onStarChanged: (favorited) => onSave?.call(move.copyWithInherited(favorited: favorited)),
    );
  }
}
