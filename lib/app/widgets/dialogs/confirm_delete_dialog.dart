import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/dialog_utils.dart';

Future<bool> confirmDelete<T>(BuildContext context, String name) {
  return Get.dialog<bool>(
    AlertDialog(
      title: Text(S.current.confirmDeleteTitle(S.current.entity(T))),
      content: Text(S.current.confirmDeleteBody(S.current.entity(T), name)),
      actions: DialogControls.delete(context,
          onDelete: () => Get.back(result: true),
          onCancel: () => Get.back(result: false)),
    ),
  ).then((res) => res == true);
}

Future<void> awaitDeleteConfirmation<T>(
        BuildContext context, String name, void Function() onConfirmed) =>
    awaitConfirmation(confirmDelete<T>(context, name), onConfirmed);
