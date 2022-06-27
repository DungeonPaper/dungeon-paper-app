import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> confirmDelete<T>(BuildContext context, String name) {
  return Get.dialog<bool>(
    AlertDialog(
      title: Text(S.current.confirmDeleteTitle(S.current.entity(T))),
      content: Text(S.current.confirmDeleteBody(S.current.entity(T), name)),
      actions: DialogControls.delete(context,
          onDelete: () => Get.back(result: true), onCancel: () => Get.back(result: false)),
    ),
  ).then((res) => res == true);
}

Future<void> awaitConfirmation(Future<bool> confirmation, void Function() callback) =>
    confirmation.then((res) {
      if (res) callback();
    });

Future<void> awaitDeleteConfirmation<T>(
        BuildContext context, String name, void Function() onConfirmed) =>
    awaitConfirmation(confirmDelete<T>(context, name), onConfirmed);
