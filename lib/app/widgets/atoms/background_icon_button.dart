import 'package:flutter/material.dart';

class BackgroundIconButton extends StatelessWidget {
  const BackgroundIconButton({
    Key? key,
    required this.icon,
    this.iconColor,
    this.color,
    required this.onPressed,
    this.size,
    this.iconSize,
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
      ),
    );
  }

  Color bgColor(BuildContext context) =>
      color ??
      ElevatedButtonTheme.of(context).style?.backgroundColor?.resolve({}) ??
      Theme.of(context).primaryColor;
}
