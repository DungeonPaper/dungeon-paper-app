import 'package:dungeon_paper/app/widgets/chips/advanced_chip.dart';
import 'package:flutter/material.dart';

class PrimaryChip extends StatelessWidget {
  const PrimaryChip({
    super.key,
    required this.label,
    this.onPressed,
    this.onDeleted,
    this.icon,
    this.visualDensity,
    this.isEnabled,
    this.backgroundColor,
    this.tooltip,
    this.deleteButtonTooltip,
  });

  final String label;
  final void Function()? onPressed;
  final void Function()? onDeleted;
  final Widget? icon;
  final VisualDensity? visualDensity;
  final Color? backgroundColor;
  final bool? isEnabled;
  final String? tooltip;
  final String? deleteButtonTooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final fgColor = isLight ? colorScheme.onPrimary : colorScheme.onSecondary;
    final bgColor = backgroundColor ??
        (isLight ? colorScheme.primary : colorScheme.secondary);
    final isCompact = visualDensity == VisualDensity.compact;
    final hasIcon = icon != null;

    return AdvancedChip(
      deleteIconColor: fgColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      avatar: hasIcon
          ? IconTheme.merge(
              data: IconThemeData(
                color: fgColor,
                size: isCompact ? 14 : 16,
              ),
              child: icon!,
            )
          : null,
      label: Text(
        label,
        style: TextStyle(color: fgColor),
        textScaleFactor: isCompact ? 0.65 : 0.85,
      ),
      padding: EdgeInsets.zero,
      backgroundColor: bgColor.withOpacity(isLight ? 0.7 : 0.4),
      labelPadding: (isCompact
              ? const EdgeInsets.symmetric(horizontal: 6, vertical: 0)
              : const EdgeInsets.symmetric(horizontal: 8, vertical: 0))
          .copyWith(left: hasIcon ? -4 : null),
      visualDensity: visualDensity,
      isEnabled: isEnabled ?? true,
      onDeleted: onDeleted,
      onPressed: onPressed,
      tooltip: tooltip,
      deleteButtonTooltipMessage: deleteButtonTooltip,
    );
  }
}
