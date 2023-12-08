import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.size = 50,
    this.tooltip,
  }) : super(key: key);

  final Widget icon;
  final void Function()? onPressed;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    if (tooltip != null) {
      return Tooltip(
        message: tooltip,
        padding: const EdgeInsets.all(8),
        preferBelow: false,
        child: _buildButton(context),
      );
    }

    return _buildButton(context);
  }

  Widget _buildButton(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bgColor = Color.alphaBlend(
        backgroundColor ?? Colors.transparent, colorScheme.primary);
    final fgColor = Color.alphaBlend(
      foregroundColor ?? Colors.transparent,
      (ThemeData.estimateBrightnessForColor(bgColor) == Brightness.light
          ? Colors.black
          : Colors.white),
    );
    return ElevatedButton(
      child: IconTheme.merge(
        child: icon,
        data: IconThemeData(size: size / 2),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.square(size),
        backgroundColor: bgColor,
        foregroundColor: fgColor,
      ),
      onPressed: onPressed,
    );
  }
}
