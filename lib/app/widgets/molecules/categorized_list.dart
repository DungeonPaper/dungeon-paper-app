import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_panel.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:flutter/material.dart';

class CategorizedList extends StatelessWidget {
  CategorizedList({
    Key? key,
    required List<Widget> children,
    required this.title,
    this.titleLeading = const [],
    this.titleTrailing = const [],
    this.onReorder,
    this.initiallyExpanded = true,
    this.itemPadding,
    this.leading = const [],
    this.trailing = const [],
  })  : itemBuilder = ((BuildContext context, int index) => children[index]),
        itemCount = children.length,
        super(key: key);

  const CategorizedList.builder({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
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
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
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
              ReorderableListView.builder(
                itemBuilder: itemBuilder,
                itemCount: itemCount,
                onReorder: onReorder!,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // buildDefaultDragHandles: true,
                // padding: itemPadding,
              ),
              ...trailing,
            ]
          : range(itemCount).map((childIndex) {
              final child = itemBuilder(context, childIndex);
              return itemPadding != null
                  ? Padding(
                      padding: itemPadding!,
                      child: child,
                    )
                  : child;
            }).toList(),
    );
  }
}
