import 'package:flutter/material.dart';

class IconSpan extends WidgetSpan {
  IconSpan(
    BuildContext context, {
    required IconData icon,
    Offset offset = Offset.zero,
    double size = 16,
    super.baseline = TextBaseline.ideographic,
    super.alignment = PlaceholderAlignment.baseline,
    super.style,
  }) : super(
          child: _wrapChild(
            context,
            icon,
            offset: offset,
            size: size,
          ),
        );

  static Widget _wrapChild(
    BuildContext context,
    IconData icon, {
    required Offset offset,
    double size = 16,
  }) =>
      Transform.translate(
        offset: offset,
        child: Text(
          String.fromCharCode(icon.codePoint),
          style: DefaultTextStyle.of(context).style.copyWith(
                fontFamily: icon.fontFamily,
                fontSize: size,
              ),
        ),
      );
}
