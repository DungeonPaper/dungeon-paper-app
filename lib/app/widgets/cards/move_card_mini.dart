import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
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
    this.onTap,
  }) : super(key: key);

  final Move move;
  final bool showStar;
  final void Function(Move move)? onSave;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCardMini(
      title: move.name,
      description: move.description,
      chips: [MoveCategoryChip(category: move.category)],
      dice: move.dice,
      icon: SvgIcon(move.icon, size: 16),
      starred: move.favorited,
      showStar: showStar,
      onStarChanged: (favorited) => onSave?.call(move.copyWithInherited(favorited: favorited)),
      onTap: onTap,
    );
  }
}
