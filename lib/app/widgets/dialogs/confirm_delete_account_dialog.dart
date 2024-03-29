import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/dialog_utils.dart';

Future<bool> confirmDeleteAccount1<T>(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(tr.dialogs.confirmations.deleteAccount.step1.title),
      content: Text(tr.dialogs.confirmations.deleteAccount.step1.body),
      actions: DialogControls.delete(
        context,
        onDelete: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    ),
  ).then((res) => res == true);
}

Future<bool> confirmDeleteAccount2<T>(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(tr.dialogs.confirmations.deleteAccount.step2.title),
      content: Text(tr.dialogs.confirmations.deleteAccount.step2.body),
      actions: DialogControls.delete(
        context,
        onDelete: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    ),
  ).then((res) => res == true);
}

Future<void> awaitDeleteAccountConfirmation<T>(
        BuildContext context, void Function() onConfirmed) =>
    awaitConfirmation(
        confirmDeleteAccount1<T>(context),
        () =>
            awaitConfirmation(confirmDeleteAccount2<T>(context), onConfirmed));
