import 'package:dungeon_paper/app/model_utils/tag_utils.dart';
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
    this.initiallyExpanded,
    this.actions = const [],
  }) : super(key: key);

  final Move move;
  final void Function(Move move)? onSave;
  final bool showDice;
  final bool showStar;
  final bool? initiallyExpanded;
  final Iterable<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: move.name,
      description: move.description,
      expansionKey: PageStorageKey(move.key),
      chips: [
        MoveCategoryChip(category: move.category),
        ...TagUtils.excludeMetaTags(move.tags).map((t) => TagChip(tag: t))
      ],
      dice: showDice ? move.dice : [],
      icon: SvgIcon(move.icon, size: 16),
      starred: move.favorited,
      showStar: showStar,
      onStarChanged: (favorited) => onSave?.call(move.copyWithInherited(favorited: favorited)),
      initiallyExpanded: initiallyExpanded,
      actions: actions,
    );
  }
}
