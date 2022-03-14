import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:flutter/material.dart';

import 'dynamic_action_card_mini.dart';

class ItemCardMini extends StatelessWidget {
  const ItemCardMini({
    Key? key,
    required this.item,
    this.showStar = true,
    this.showIcon = true,
    this.onSave,
    this.onTap,
  }) : super(key: key);

  final Item item;
  final bool showStar;
  final bool showIcon;
  final void Function(Item item)? onSave;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCardMini(
      title: item.name,
      description: item.description,
      chips: const [], // item.tags.map((t) => TagChip(tag: t)),
      dice: const [],
      icon: showIcon ? SvgIcon(item.icon, size: 16) : null,
      starred: item.equipped,
      showStar: showStar,
      onStarChanged: (equipped) => onSave?.call(item.copyWithInherited(equipped: equipped)),
      onTap: onTap,
    );
  }
}
