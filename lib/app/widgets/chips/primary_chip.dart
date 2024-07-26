import 'package:dungeon_paper/app/themes/theme_utils.dart';
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
    this.isEnabled = true,
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
  final bool isEnabled;
  final String? tooltip;
  final String? deleteButtonTooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLight = theme.brightness == Brightness.light;
    final bgColor = backgroundColor ??
        (isLight ? colorScheme.primary : colorScheme.secondary);
    final fgColor = isEnabled
        ? accessibleColorFor(
            isLight ? colorScheme.onPrimary : colorScheme.onSecondary, bgColor)
        : colorScheme.onSurface.withOpacity(0.7);
    final disabledBgColor = bgColor.withOpacity(isLight ? 0.4 : 0.1);
    final isCompact = visualDensity == VisualDensity.compact;
    final hasIcon = icon != null;

    final labelPadding =
        EdgeInsets.symmetric(horizontal: 8 - isCompact.cInt * 2, vertical: 0)
            .copyWith(
                left: (hasIcon
                    ? (label.isEmpty ? -8 + isCompact.cInt * 2 : -4)
                    : null));

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
        textScaler: isCompact
            ? const TextScaler.linear(0.65)
            : const TextScaler.linear(0.85),
      ),
      padding: EdgeInsets.zero,
      backgroundColor: bgColor.withOpacity(isLight ? 0.7 : 0.4),
      disabledColor: disabledBgColor,
      labelPadding: labelPadding,
      visualDensity: visualDensity,
      isEnabled: isEnabled,
      onDeleted: onDeleted,
      onPressed: onPressed,
      tooltip: tooltip,
      deleteButtonTooltipMessage: deleteButtonTooltip,
    );
  }
}

extension on bool {
  int get cInt => this ? 1 : 0;
}
