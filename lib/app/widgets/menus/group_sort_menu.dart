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
    return PopupMenuButton<String>(
      iconSize: 20,
      itemBuilder: (ctx) => menuItems(index: index, maxIndex: maxIndex),
      onSelected: (value) => getOnSelected(value, index, onReorder),
    );
  }

  static getOnSelected(
    String value,
    int index,
    void Function(int oldIndex, int newIndex) onReorder,
  ) =>
      {
        'up': () => onReorder(index, index - 1),
        'down': () => onReorder(index, index + 1),
      }[value]
          ?.call();

  static List<PopupMenuItem<String>> menuItems({
    required int index,
    required int maxIndex,
  }) {
    return [
      PopupMenuItem(
        enabled: index > 0,
        value: 'up',
        child: Row(
          children: const [
            Icon(Icons.move_up),
            SizedBox(width: 8),
            // TODO intl
            Text('Move up'),
          ],
        ),
      ),
      PopupMenuItem(
        enabled: index < maxIndex,
        value: 'down',
        child: Row(
          children: const [
            Icon(Icons.move_down),
            SizedBox(width: 8),
            // TODO intl
            Text('Move down'),
          ],
        ),
      ),
    ];
  }
}
