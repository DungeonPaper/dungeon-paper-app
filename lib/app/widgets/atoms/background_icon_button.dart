import 'package:flutter/material.dart';

class BackgroundIconButton extends StatelessWidget {
  const BackgroundIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.iconSize,
    this.visualDensity,
    this.padding = const EdgeInsets.all(8.0),
    this.alignment = Alignment.center,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback = true,
    this.constraints,
    this.iconColor,
    this.size,
    this.decoration,
    this.shadows,
    this.elevation,
  }) : super(key: key);

  final Widget icon;

  /// color of the icon
  final Color? iconColor;

  /// background color of the button, for icon use `iconColor`
  final Color? color;

  /// size of the button, for icon use `iconSize`
  final double? size;
  // size of the icon, if not specified in the `icon` itself or the closest `IconTheme`
  final double? iconSize;
  final void Function()? onPressed;

  /// overrides `shadows`
  final ShapeDecoration? decoration;

  /// overridden by `decoration`
  final List<BoxShadow>? shadows;

  /// overrides `shadows`, overridden by `decoration`
  final double? elevation;

  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;
  final double? splashRadius;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? disabledColor;
  final MouseCursor? mouseCursor;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? tooltip;
  final bool enableFeedback;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    if (elevation != null) {
      return PhysicalModel(
        borderRadius: BorderRadius.circular(100),
        color: bgColor(context),
        elevation: elevation!,
        child: buildButton(context),
      );
    }
    return buildButton(context);
  }

  Widget buildButton(BuildContext context) {
    final iconTheme = IconTheme.of(context);

    return Ink(
      decoration: decoration ??
          ShapeDecoration(
            color: bgColor(context),
            shape: const CircleBorder(),
            shadows: elevation == null ? shadows : null,
          ),
      width: size,
      height: size,
      child: IconButton(
        icon: icon,
        iconSize: iconSize ?? iconTheme.size,
        color: iconColor ?? iconTheme.color,
        onPressed: onPressed,
        visualDensity: visualDensity,
        padding: padding,
        alignment: alignment,
        splashRadius: splashRadius,
        focusColor: focusColor,
        hoverColor: hoverColor,
        splashColor: Theme.of(context).splashColor,
        highlightColor: highlightColor,
        disabledColor: disabledColor,
        mouseCursor: mouseCursor,
        focusNode: focusNode,
        autofocus: autofocus,
        tooltip: tooltip,
        enableFeedback: enableFeedback,
        constraints: constraints,
      ),
    );
  }

  Color bgColor(BuildContext context) =>
      color ??
      ElevatedButtonTheme.of(context).style?.backgroundColor?.resolve({}) ??
      Theme.of(context).primaryColor;
}
