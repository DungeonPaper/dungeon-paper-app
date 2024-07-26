import 'package:flutter/material.dart';

class HelpTooltipIcon extends StatelessWidget {
  final String tooltipText;
  final double? size;

  const HelpTooltipIcon({super.key, required this.tooltipText, this.size});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipText,
      child: Icon(Icons.help, size: size),
    );
  }
}
