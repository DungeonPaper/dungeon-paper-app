import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_panel.dart';
import 'package:flutter/material.dart';

class CategorizedList extends StatelessWidget {
  const CategorizedList({
    Key? key,
    required this.children,
    required this.title,
    this.titleLeading = const [],
    this.titleTrailing = const [],
    this.onReorder,
    this.initiallyExpanded = true,
    this.itemPadding,
    this.leading = const [],
    this.trailing = const [],
  }) : super(key: key);

  final Widget title;
  final List<Widget> children;
  final List<Widget> titleLeading;
  final List<Widget> titleTrailing;
  final List<Widget> leading;
  final List<Widget> trailing;
  final bool initiallyExpanded;
  final void Function(int oldIndex, int newIndex)? onReorder;
  final EdgeInsets? itemPadding;

  @override
  Widget build(BuildContext context) {
    return CustomExpansionPanel(
      title: title,
      trailing: titleTrailing,
      leading: titleLeading,
      initiallyExpanded: initiallyExpanded,
      children: onReorder != null
          ? [
              ...leading,
              ReorderableListView(
                children: children,
                onReorder: onReorder!,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // buildDefaultDragHandles: true,
                // padding: itemPadding,
              ),
              ...trailing,
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
