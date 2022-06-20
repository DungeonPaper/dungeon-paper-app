import 'package:dungeon_paper/app/themes/themes.dart' as t;
import 'package:flutter/material.dart';

class ButtonThemes {
  static final rRectShape = t.rRectShape;

  static ButtonStyle? primaryElevated(BuildContext context, {double? backgroundOpacity}) =>
      ElevatedButton.styleFrom();
  // ElevatedButton.styleFrom(
  //   primary: Theme.of(context).primaryColor.withOpacity(backgroundOpacity ?? 1),
  //   shape: rRectShape,
  // );

  static ButtonStyle? errorElevated(BuildContext context) => ElevatedButton.styleFrom(
        primary: Theme.of(context).errorColor,
        shape: rRectShape,
      );

  static ButtonStyle? errorText(BuildContext context) => TextButton.styleFrom(
        primary: Theme.of(context).errorColor,
        shape: rRectShape,
      );

  static ButtonStyle? primaryOutlined(BuildContext context) => OutlinedButton.styleFrom(
        primary: Theme.of(context).scaffoldBackgroundColor.computeLuminance() > 0.5
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.onSurface,
        shape: rRectShape,
      );
}
