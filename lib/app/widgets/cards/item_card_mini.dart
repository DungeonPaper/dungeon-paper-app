import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/app/widgets/chips/move_category_chip.dart';
import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:flutter/material.dart';

import '../../data/models/move.dart';
import 'dynamic_action_card_mini.dart';

class ItemCardMini extends StatelessWidget {
  const ItemCardMini({
    Key? key,
    required this.item,
    this.showStar = true,
    this.onSave,
    this.onTap,
  }) : super(key: key);

  final Item item;
  final bool showStar;
  final void Function(Item item)? onSave;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCardMini(
      title: item.name,
      description: item.description,
      chips: const [], // item.tags.map((t) => TagChip(tag: t)),
      dice: const [],
      icon: SvgIcon(item.icon, size: 16),
      starred: item.equipped,
      showStar: showStar,
      onStarChanged: (equipped) => onSave?.call(item.copyWithInherited(equipped: equipped)),
      onTap: onTap,
    );
  }
}
