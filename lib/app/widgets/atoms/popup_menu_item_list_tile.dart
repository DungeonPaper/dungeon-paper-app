import 'package:flutter/material.dart';

class PopupMenuItemListTile extends StatelessWidget {
  const PopupMenuItemListTile({
    Key? key,
    required this.label,
    this.icon,
  }) : super(key: key);

  final Widget label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return label;
    }

    return Row(
      children: [icon!, const SizedBox(width: 8), label],
    );
  }
}
