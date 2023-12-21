import 'package:flutter/material.dart';

class LabeledDivider extends StatelessWidget {
  const LabeledDivider({
    super.key,
    required this.label,
    this.height = 48,
    this.gap = 8,
  });

  final Widget label;
  final double height;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(height: height)),
        SizedBox(width: gap),
        label,
        SizedBox(width: gap),
        Expanded(child: Divider(height: height)),
      ],
    );
  }
}
