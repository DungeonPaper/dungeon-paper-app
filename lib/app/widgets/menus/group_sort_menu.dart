import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class GroupSortMenu extends StatelessWidget {
  const GroupSortMenu({
    Key? key,
    required this.index,
    required this.maxIndex,
    required this.onReorder,
  }) : super(key: key);

  final int index;
  final int maxIndex;
  final void Function(int oldIndex, int newIndex) onReorder;

  @override
  Widget build(BuildContext context) {
    return MenuButton<String>(
      iconSize: 20,
      items: [
        MenuEntry(
          disabled: index <= 0,
          id: 'up',
          icon: const Icon(Icons.move_up),
          label: Text(S.current.sortMoveUp),
          onSelect: () => onReorder(index, index - 1),
        ),
        MenuEntry(
          disabled: index >= maxIndex - 1,
          id: 'down',
          icon: const Icon(Icons.move_down),
          label: Text(S.current.sortMoveDown),
          onSelect: () => onReorder(index, index + 1),
        ),
      ],
    );
  }
}
