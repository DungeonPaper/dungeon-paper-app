import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'custom_expansion_tile.dart';

class CustomExpansionPanel extends StatelessWidget {
  final bool expandable;
  final Key? expansionKey;
  final Widget? title;
  final Widget? subtitle;
  final List<Widget> children;
  final bool? expanded;
  final bool? initiallyExpanded;
  final void Function(bool)? onExpansion;
  final bool showArrow;
  final EdgeInsets? titlePadding;
  final EdgeInsets? childrenPadding;
  final List<Widget> leading;
  final List<Widget> trailing;
  final Widget? icon;
  final double minIconWidth;
  final Color? iconColor;
  final Color? collapsedIconColor;
  final Color? textColor;
  final Color? collapsedTextColor;
  final Widget Function(BuildContext context, Color color)? titleBuilder;

  static const defaultPadding = EdgeInsets.symmetric(horizontal: 8);

  const CustomExpansionPanel({
    Key? key,
    this.expandable = true,
    this.expansionKey,
    this.title,
    this.titleBuilder,
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
    this.iconColor,
    this.collapsedIconColor,
    this.textColor,
    this.collapsedTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final originalTheme = Theme.of(context);
    return CustomExpansionTile(
      key: expansionKey,
      initiallyExpanded: initiallyExpanded ?? false,
      onExpansionChanged: (state) => onExpansion?.call(state),
      expandable: expandable,
      title: title,
      titleBuilder: titleBuilder,
      icon: icon,
      minIconWidth: minIconWidth,
      subtitle: subtitle,
      children: children.map((child) => Theme(data: originalTheme, child: child)).toList(),
      tilePadding: titlePadding ?? defaultPadding,
      childrenPadding: childrenPadding ?? defaultPadding,
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      // trailing: !showArrow ? const [SizedBox.shrink()] : [],
      leading: leading,
      trailing: trailing,
      visualDensity: VisualDensity.compact,
      iconColor: iconColor,
      collapsedIconColor: collapsedIconColor,
      textColor: textColor,
      collapsedTextColor: collapsedTextColor,
    );
  }
}
