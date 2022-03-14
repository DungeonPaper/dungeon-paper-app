import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:flutter/material.dart';

import '../../data/models/item.dart';
import 'dynamic_action_card.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.item,
    this.showStar = true,
    this.showIcon = true,
    this.onSave,
    this.initiallyExpanded,
    this.actions = const [],
  }) : super(key: key);

  final Item item;
  final bool showStar;
  final bool showIcon;
  final bool? initiallyExpanded;
  final void Function(Item item)? onSave;
  final Iterable<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      initiallyExpanded: initiallyExpanded,
      title: item.name,
      description: item.description,
      chips: item.tags.map((t) => TagChip(tag: t)),
      dice: const [],
      icon: showIcon ? SvgIcon(item.icon, size: 16) : null,
      starred: item.equipped,
      showStar: showStar,
      onStarChanged: (equipped) => onSave?.call(item.copyWithInherited(equipped: equipped)),
      actions: actions,
    );
  }
}
