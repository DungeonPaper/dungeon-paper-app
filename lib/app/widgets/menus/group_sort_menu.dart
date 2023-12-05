import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../data/services/intl_service.dart';

class GroupSortMenu extends StatelessWidget {
  const GroupSortMenu({
    Key? key,
    required this.index,
    required this.totalItemCount,
    required this.onReorder,
    this.leading = const [],
    this.trailing = const [],
  }) : super(key: key);

  final int index;
  final int totalItemCount;
  final List<MenuEntry<String>> leading;
  final List<MenuEntry<String>> trailing;
  final void Function(int oldIndex, int newIndex) onReorder;

  @override
  Widget build(BuildContext context) {
    return MenuButton<String>(
      iconSize: 20,
      items: [
        ...leading,
        MenuEntry(
          disabled: index <= 0,
          value: 'up',
          icon: const Icon(Icons.move_up),
          label: Text(tr.sort.moveUp),
          onSelect: () => onReorder(index, index - 1),
        ),
        MenuEntry(
          disabled: index >= totalItemCount - 1,
          value: 'down',
          icon: const Icon(Icons.move_down),
          label: Text(tr.sort.moveDown),
          onSelect: () => onReorder(index, index + 1),
        ),
        ...trailing,
      ],
    );
  }
}
