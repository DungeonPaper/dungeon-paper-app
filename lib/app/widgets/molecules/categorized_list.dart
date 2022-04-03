import 'package:dungeon_paper/app/widgets/atoms/expansion_row.dart';
import 'package:flutter/material.dart';

class CategorizedList extends StatelessWidget {
  const CategorizedList({
    Key? key,
    required this.children,
    required this.title,
    this.trailing = const [],
    this.leading = const [],
    this.onReorder,
    this.initiallyExpanded = true,
    this.itemPadding,
  }) : super(key: key);

  final Widget title;
  final List<Widget> children;
  final List<Widget> trailing;
  final List<Widget> leading;
  final bool initiallyExpanded;
  final void Function(int oldIndex, int newIndex)? onReorder;
  final EdgeInsets? itemPadding;

  @override
  Widget build(BuildContext context) {
    return ExpansionRow(
      title: title,
      trailing: trailing,
      initiallyExpanded: initiallyExpanded,
      children: onReorder != null
          ? [
              ReorderableListView(
                children: children,
                onReorder: onReorder!,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // buildDefaultDragHandles: true,
                // padding: itemPadding,
              )
            ]
          : children
              .map((child) => itemPadding != null
                  ? Padding(
                      padding: itemPadding!,
                      child: child,
                    )
                  : child)
              .toList(),
    );
  }
}
