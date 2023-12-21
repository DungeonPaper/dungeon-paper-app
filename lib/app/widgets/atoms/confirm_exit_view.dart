import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/dialog_utils.dart';

class ConfirmExitView extends StatelessWidget {
  const ConfirmExitView({
    super.key,
    this.title,
    this.text,
    this.okLabel,
    this.cancelLabel,
    this.dirty = true,
    required this.child,
  });

  final Widget? title;
  final Widget? text;
  final String? okLabel;
  final String? cancelLabel;
  final Widget child;
  final bool dirty;

  static final _defaultTitle = Text(tr.dialogs.confirmations.exit.title);
  static final _defaultText = Text(tr.dialogs.confirmations.exit.body);

  @override
  Widget build(BuildContext context) {
    // TODO update, but of course they made the new version suck.
    return WillPopScope(
      child: child,
      onWillPop: () async {
        if (!dirty) {
          return true;
        }
        return confirmExit(
          context,
          title: title,
          text: text,
          okLabel: okLabel,
          cancelLabel: cancelLabel,
        );
      },
    );
  }
}

Future<bool> confirmExit<T>(
  BuildContext context, {
  Widget? title,
  Widget? text,
  String? okLabel,
  String? cancelLabel,
}) {
  return showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmExitDialog()).then((res) => res == true);
}

class ConfirmExitDialog extends StatelessWidget {
  final Widget? title;
  final Widget? text;
  final String? okLabel;
  final String? cancelLabel;

  const ConfirmExitDialog({
    super.key,
    this.title,
    this.text,
    this.okLabel,
    this.cancelLabel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title ?? ConfirmExitView._defaultTitle,
      content: text ?? ConfirmExitView._defaultText,
      actions: DialogControls.confirmExit(
        context,
        exitLabel: okLabel,
        onExit: () => Navigator.of(context).pop(true),
        continueLabel: cancelLabel,
        onContinue: () => Navigator.of(context).pop(false),
      ),
    );
  }
}

Future<void> awaitExitConfirmation<T>(
  BuildContext context,
  void Function() onConfirmed, {
  Widget? title,
  Widget? text,
  String? okLabel,
  String? cancelLabel,
}) =>
    awaitConfirmation(
        confirmExit<T>(
          context,
          title: title,
          text: text,
          okLabel: okLabel,
          cancelLabel: cancelLabel,
        ),
        onConfirmed);
