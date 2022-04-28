import 'package:dungeon_paper/app/themes/button_themes.dart';
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
  final Widget? okLabel;
  final Widget? cancelLabel;
  final Widget child;
  final bool dirty;

  static final _defaultTitle = Text(S.current.confirmExitDefaultTitle);
  static final _defaultText = Text(S.current.confirmExitDefaultText);
  static final _defaultOkLabel = Text(S.current.confirmExitDefaultOkLabel);
  static final _defaultCancelLabel = Text(S.current.confirmExitDefaultCancelLabel);

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
  Widget? okLabel,
  Widget? cancelLabel,
}) {
  return Get.dialog<bool>(
    AlertDialog(
      title: title ?? ConfirmExitView._defaultTitle,
      content: text ?? ConfirmExitView._defaultText,
      actions: [
        ElevatedButton.icon(
          icon: const Icon(Icons.close),
          label: okLabel ?? ConfirmExitView._defaultOkLabel,
          onPressed: () => Get.back(result: true),
          style: ButtonThemes.errorElevated(context),
        ),
        TextButton(
          // icon: const Icon(Icons.close),
          child: cancelLabel ?? ConfirmExitView._defaultCancelLabel,
          onPressed: () => Get.back(result: false),
          // style: ButtonThemes.primaryElevated(context),
        ),
        // const SizedBox(width: 8),
        // const SizedBox(width: 0),
      ],
    ),
  ).then((res) => res == true);
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
  Widget? okLabel,
  Widget? cancelLabel,
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
