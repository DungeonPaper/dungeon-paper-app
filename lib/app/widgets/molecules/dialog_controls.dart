import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class DialogControls {
  static List<Widget> custom(
    BuildContext context, {
    required void Function() onConfirm,
    required String confirmLabel,
    Widget? confirmIcon,
    required void Function() onCancel,
    required String cancelLabel,
    Widget? cancelIcon,
    double? spacing = 0,
  }) =>
      [
        if (cancelIcon != null)
          TextButton.icon(
            onPressed: onCancel,
            icon: cancelIcon,
            label: Text(cancelLabel),
            style: ButtonThemes.errorText(context),
          ),
        if (cancelIcon == null)
          TextButton(
            onPressed: onCancel,
            child: Text(cancelLabel),
            style: ButtonThemes.errorText(context),
          ),
        if (spacing != null && spacing > 0) SizedBox(width: spacing),
        if (confirmIcon != null)
          ElevatedButton.icon(
            onPressed: onConfirm,
            icon: confirmIcon,
            label: Text(confirmLabel),
          ),
        if (confirmIcon == null)
          ElevatedButton(
            onPressed: onConfirm,
            child: Text(confirmLabel),
          ),
      ];

  static List<Widget> negative(
    BuildContext context, {
    required void Function() onConfirm,
    required String confirmLabel,
    Widget? confirmIcon,
    required void Function() onCancel,
    required String cancelLabel,
    Widget? cancelIcon,
    double? spacing = 0,
  }) =>
      [
        if (cancelIcon != null)
          TextButton.icon(
            onPressed: onCancel,
            icon: cancelIcon,
            label: Text(cancelLabel),
          ),
        if (cancelIcon == null)
          TextButton(
            onPressed: onCancel,
            child: Text(cancelLabel),
          ),
        if (spacing != null && spacing > 0) SizedBox(width: spacing),
        if (confirmIcon != null)
          ElevatedButton.icon(
            onPressed: onConfirm,
            icon: confirmIcon,
            label: Text(confirmLabel),
            style: ButtonThemes.errorElevated(context),
          ),
        if (confirmIcon == null)
          ElevatedButton(
            onPressed: onConfirm,
            child: Text(confirmLabel),
            style: ButtonThemes.errorElevated(context),
          ),
      ];

  static List<Widget> confirmExit(
    BuildContext context, {
    required void Function() onExit,
    String? exitLabel,
    required void Function() onContinue,
    String? continueLabel,
    double? spacing = 0,
  }) =>
      negative(
        context,
        confirmLabel: exitLabel ?? S.current.confirmExitDefaultOkLabel,
        confirmIcon: const Icon(Icons.close),
        onConfirm: onExit,
        cancelLabel: continueLabel ?? S.current.confirmExitDefaultCancelLabel,
        // cancelIcon: const Icon(Icons.close),
        onCancel: onContinue,
        spacing: spacing,
      );

  static List<Widget> save(
    BuildContext context, {
    required void Function() onSave,
    required void Function() onCancel,
    double? spacing = 0,
  }) =>
      custom(
        context,
        confirmIcon: const Icon(Icons.check),
        confirmLabel: S.current.save,
        onConfirm: onSave,
        cancelIcon: const Icon(Icons.close),
        cancelLabel: S.current.cancel,
        onCancel: onCancel,
        spacing: spacing,
      );

  static List<Widget> delete(
    BuildContext context, {
    required void Function() onDelete,
    required void Function() onCancel,
    double? spacing = 0,
  }) =>
      negative(
        context,
        confirmIcon: const Icon(Icons.delete),
        confirmLabel: S.current.remove,
        onConfirm: onDelete,
        cancelIcon: const Icon(Icons.close),
        cancelLabel: S.current.cancel,
        onCancel: onCancel,
        spacing: spacing,
      );

  static List<Widget> done(BuildContext context, void Function() onDone) => [
        ElevatedButton.icon(
          onPressed: onDone,
          icon: const Icon(Icons.check),
          label: Text(S.current.done),
        ),
      ];
}
