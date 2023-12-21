import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/dialog_utils.dart';

Future<bool> confirmDelete<T>(BuildContext context, String name, [Type? t]) {
  final type = t ?? T;
  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(tr.dialogs.confirmations.delete.title(tr.entity(tn(type)))),
      content:
          Text(tr.dialogs.confirmations.delete.body(tr.entity(tn(type)), name)),
      actions: DialogControls.delete(
        context,
        onDelete: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    ),
  ).then((res) => res == true);
}

Future<void> awaitDeleteConfirmation<T>(
  BuildContext context,
  String name,
  void Function() onConfirmed, [
  Type? t,
]) =>
    awaitConfirmation(confirmDelete<T>(context, name, t), onConfirmed);
