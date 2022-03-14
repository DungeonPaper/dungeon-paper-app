import 'package:flutter/material.dart';

import 'custom_expansion_tile.dart';

class ExpansionRow extends StatelessWidget {
  final Key? expansionKey;
  final Widget title;
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

  static const defaultPadding = EdgeInsets.symmetric(horizontal: 8);

  const ExpansionRow({
    Key? key,
    this.expansionKey,
    required this.title,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ListTileTheme(
        data: ListTileTheme.of(context).copyWith(
          horizontalTitleGap: 0,
          minLeadingWidth: 36,
        ),
        child: CustomExpansionTile(
          key: expansionKey,
          initiallyExpanded: initiallyExpanded ?? false,
          onExpansionChanged: (state) => onExpansion?.call(!state),
          title: Row(
            children: [
              if (icon != null) ...[
                IconTheme(data: IconTheme.of(context).copyWith(size: 20), child: icon!),
                const SizedBox(width: 8),
              ],
              ...leading,
              Expanded(child: title),
              ...trailing,
            ],
          ),
          children: children,
          tilePadding: titlePadding ?? defaultPadding,
          childrenPadding: childrenPadding ?? defaultPadding,
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          trailing: !showArrow ? const SizedBox.shrink() : null,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
