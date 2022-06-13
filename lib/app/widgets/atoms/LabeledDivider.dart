import 'package:flutter/material.dart';

class LabeledDivider extends StatelessWidget {
  const LabeledDivider({
    Key? key,
    required this.label,
  }) : super(key: key);

  final Widget label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(height: 48)),
        const SizedBox(width: 8),
        label,
        const SizedBox(width: 8),
        const Expanded(child: Divider(height: 48)),
      ],
    );
  }
}
