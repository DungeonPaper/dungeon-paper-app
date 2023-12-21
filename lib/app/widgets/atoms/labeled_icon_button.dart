import 'package:dungeon_paper/app/widgets/atoms/background_icon_button.dart';
import 'package:flutter/material.dart';

class LabeledIconButton extends StatelessWidget {
  const LabeledIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.shadowOffset,
  });

  final Widget icon;
  final void Function() onPressed;
  final String label;
  final Offset shadowOffset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var fgColor = theme.colorScheme.onPrimary;
    return BackgroundIconButton(
      size: 64,
      iconColor: fgColor,
      color: theme.primaryColor,
      onPressed: onPressed,
      shadows: [
        BoxShadow(
            offset: shadowOffset,
            blurRadius: 4,
            color: Colors.black.withOpacity(0.2)),
      ],
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          Text(
            label,
            textScaleFactor: 0.8,
            style: TextStyle(color: fgColor),
          ),
        ],
      ),
    );
  }
}
