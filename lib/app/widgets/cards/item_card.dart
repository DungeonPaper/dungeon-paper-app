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
  }) : super(key: key);

  final Item item;
  final bool showStar;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: item.name,
      body: [Text(item.description)],
      chips: item.tags.map((t) => TagChip(tag: t)),
      dice: [],
      icon: SvgIcon(item.icon, size: 16),
      starred: item.equipped,
      showStar: showStar,
    );
  }
}
