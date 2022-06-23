import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmExitView extends StatelessWidget {
  const ConfirmExitView({
    Key? key,
    this.title,
    this.text,
    this.okLabel,
    this.cancelLabel,
    this.dirty = true,
    required this.child,
  }) : super(key: key);

  final Widget? title;
  final Widget? text;
  final String? okLabel;
  final String? cancelLabel;
  final Widget child;
  final bool dirty;

  static final _defaultTitle = Text(S.current.confirmExitDefaultTitle);
  static final _defaultText = Text(S.current.confirmExitDefaultText);

  @override
  Widget build(BuildContext context) {
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
  return Get.dialog<bool>(const ConfirmExitDialog()).then((res) => res == true);
}

class ConfirmExitDialog extends StatelessWidget {
  final Widget? title;
  final Widget? text;
  final String? okLabel;
  final String? cancelLabel;

  const ConfirmExitDialog({
    Key? key,
    this.title,
    this.text,
    this.okLabel,
    this.cancelLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title ?? ConfirmExitView._defaultTitle,
      content: text ?? ConfirmExitView._defaultText,
      actions: DialogControls.confirmExit(
        context,
        exitLabel: okLabel,
        onExit: () => Get.back(result: true),
        continueLabel: cancelLabel,
        onContinue: () => Get.back(result: false),
      ),
    );
  }
}

Future<void> awaitConfirmation(Future<bool> confirmation, void Function() callback) =>
    confirmation.then((res) {
      if (res) callback();
    });

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
