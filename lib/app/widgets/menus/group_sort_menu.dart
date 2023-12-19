import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class GroupSortMenu extends StatelessWidget {
  const GroupSortMenu({
    super.key,
    required this.index,
    required this.totalItemCount,
    required this.onReorder,
    this.leading = const [],
    this.trailing = const [],
  });

  final int index;
  final int totalItemCount;
  final List<MenuEntry<String>> leading;
  final List<MenuEntry<String>> trailing;
  final void Function(BuildContext context, int oldIndex, int newIndex) onReorder;

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
          onSelect: () => onReorder(context, index, index - 1),
        ),
        MenuEntry(
          disabled: index >= totalItemCount - 1,
          value: 'down',
          icon: const Icon(Icons.move_down),
          label: Text(tr.sort.moveDown),
          onSelect: () => onReorder(context, index, index + 1),
        ),
        ...trailing,
      ],
    );
  }
}
