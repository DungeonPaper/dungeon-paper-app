import 'package:flutter/material.dart';

class ExpansionRow extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  final bool? expanded;
  final void Function(bool)? onExpansion;
  final bool showArrow;

  const ExpansionRow({
    Key? key,
    required this.title,
    required this.children,
    this.expanded,
    this.onExpansion,
    this.showArrow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ListTileTheme(
        data: ListTileTheme.of(context),
        child: ExpansionTile(
          title: title,
          children: children,
          tilePadding: const EdgeInsets.symmetric(horizontal: 8),
          // expandedAlignment: Alignment.center,
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          trailing: !showArrow ? const SizedBox.shrink() : null,
        ),
      ),
    );
  }
}
