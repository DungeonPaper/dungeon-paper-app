import 'package:flutter/material.dart';

import 'custom_expansion_tile.dart';

class ExpansionRow extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  final bool? expanded;
  final void Function(bool)? onExpansion;
  final bool showArrow;
  final EdgeInsets? titlePadding;
  final EdgeInsets? childrenPadding;
  final Widget? leading;
  final Widget? trailing;

  static const defaultPadding = EdgeInsets.symmetric(horizontal: 8);

  const ExpansionRow({
    Key? key,
    required this.title,
    required this.children,
    this.expanded,
    this.titlePadding,
    this.childrenPadding,
    this.leading,
    this.trailing,
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
          onExpansionChanged: (state) => onExpansion?.call(!state),
          title: Row(
            children: [
              Expanded(child: title),
              if (trailing != null) trailing!,
            ],
          ),
          children: children,
          tilePadding: titlePadding ?? defaultPadding,
          childrenPadding: childrenPadding ?? defaultPadding,
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          trailing: showArrow ? (!showArrow ? const SizedBox.shrink() : null) : null,
          leading: leading,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
