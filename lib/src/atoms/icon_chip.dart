import 'package:flutter/material.dart';

class IconChip extends StatelessWidget {
  final Widget label;
  final Widget icon;
  final double spacing;
  final TextStyle labelStyle;
  final EdgeInsets labelPadding;
  final Widget deleteIcon;
  final VoidCallback onDeleted;
  final Color deleteIconColor;
  final bool useDeleteButtonTooltip;
  final String deleteButtonTooltipMessage;
  final BorderSide side;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final FocusNode focusNode;
  final bool autofocus;
  final Color backgroundColor;
  final EdgeInsets padding;
  final VisualDensity visualDensity;
  final MaterialTapTargetSize materialTapTargetSize;
  final double elevation;
  final Color shadowColor;

  const IconChip({
    Key key,
    this.label,
    this.icon,
    this.spacing,
    this.labelStyle,
    this.labelPadding,
    this.deleteIcon,
    this.onDeleted,
    this.deleteIconColor,
    this.useDeleteButtonTooltip = true,
    this.deleteButtonTooltipMessage,
    this.side,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.backgroundColor,
    this.padding,
    this.visualDensity,
    this.materialTapTargetSize,
    this.elevation,
    this.shadowColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(width: spacing),
          label,
        ],
      ),
      labelStyle: labelStyle,
      labelPadding: labelPadding,
      deleteIcon: deleteIcon,
      onDeleted: onDeleted,
      deleteIconColor: deleteIconColor,
      useDeleteButtonTooltip: useDeleteButtonTooltip,
      deleteButtonTooltipMessage: deleteButtonTooltipMessage,
      side: side,
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      backgroundColor: backgroundColor,
      padding: padding,
      visualDensity: visualDensity,
      materialTapTargetSize: materialTapTargetSize,
      elevation: elevation,
      shadowColor: shadowColor,
    );
  }
}
