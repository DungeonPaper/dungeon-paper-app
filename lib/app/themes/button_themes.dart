import 'package:flutter/material.dart';

class ButtonThemes {
  static final borderRadius = BorderRadius.circular(10);
  static final rRectShape = RoundedRectangleBorder(borderRadius: borderRadius);

  static ButtonStyle primaryElevated(BuildContext context, {double? backgroundOpacity}) =>
      ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor.withOpacity(backgroundOpacity ?? 1),
        shape: rRectShape,
      );

  static ButtonStyle errorElevated(BuildContext context) => ElevatedButton.styleFrom(
        primary: Theme.of(context).errorColor,
        shape: rRectShape,
      );

  static ButtonStyle primaryOutlined(BuildContext context) => OutlinedButton.styleFrom(
        primary: Theme.of(context).scaffoldBackgroundColor.computeLuminance() > 0.5
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.onSurface,
        shape: rRectShape,
      );
}
