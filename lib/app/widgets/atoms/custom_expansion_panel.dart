import 'package:flutter/material.dart';

import 'custom_expansion_tile.dart';

class CustomExpansionPanel extends StatelessWidget {
  final bool expandable;
  final Key? expansionKey;
  final Widget title;
  final Widget? subtitle;
  final List<Widget> children;
  final bool? expanded;
  final bool? initiallyExpanded;
  final void Function(bool)? onExpansion;
  final bool showArrow;
  final EdgeInsets? titlePadding;
  final EdgeInsets? childrenPadding;
  final Iterable<Widget> leading;
  final Iterable<Widget> trailing;
  final Widget? icon;
  final double minIconWidth;

  static const defaultPadding = EdgeInsets.symmetric(horizontal: 8);

  const CustomExpansionPanel({
    Key? key,
    this.expandable = true,
    this.expansionKey,
    required this.title,
    this.subtitle,
    required this.children,
    this.icon,
    this.expanded,
    this.initiallyExpanded,
    this.titlePadding,
    this.childrenPadding,
    this.leading = const [],
    this.trailing = const [],
    this.onExpansion,
    this.showArrow = true,
    this.minIconWidth = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final originalTheme = Theme.of(context);
    return Theme(
      data: originalTheme.copyWith(dividerColor: Colors.transparent),
      child: CustomExpansionTile(
        key: expansionKey,
        initiallyExpanded: initiallyExpanded ?? false,
        onExpansionChanged: (state) => onExpansion?.call(state),
        expandable: expandable,
        title: Row(
          children: [
            if (icon != null) ...[
              SizedBox(
                width: minIconWidth,
                child: icon!,
              ),
              const SizedBox(width: 8),
            ],
            ...leading,
            Expanded(child: title),
            ...trailing,
          ],
        ),
        subtitle: subtitle,
        children: children.map((child) => Theme(data: originalTheme, child: child)).toList(),
        tilePadding: titlePadding ?? defaultPadding,
        childrenPadding: childrenPadding ?? defaultPadding,
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        trailing: !showArrow ? const SizedBox.shrink() : null,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
