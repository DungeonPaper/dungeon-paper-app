import 'package:flutter/material.dart';

class HelpText extends StatelessWidget {
  const HelpText({
    Key? key,
    required this.text,
    this.icon,
  }) : super(key: key);

  final String text;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.translate(
          offset: const Offset(0, 2),
          child: Container(
            child: IconTheme.merge(
              child: icon ?? const Icon(Icons.question_mark),
              data: IconThemeData(
                size: 12,
                color: theme.cardColor,
              ),
            ),
            decoration: BoxDecoration(
              color: textTheme.bodySmall!.color,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
