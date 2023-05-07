import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/dialog_utils.dart';

Future<bool> confirmDeleteAccount1<T>(BuildContext context) {
  return Get.dialog<bool>(
    AlertDialog(
      title: Text(S.current.confirmDeleteAccount1Title),
      content: Text(S.current.confirmDeleteAccount1Body),
      actions: DialogControls.delete(context,
          onDelete: () => Get.back(result: true), onCancel: () => Get.back(result: false)),
    ),
  ).then((res) => res == true);
}

Future<bool> confirmDeleteAccount2<T>(BuildContext context) {
  return Get.dialog<bool>(
    AlertDialog(
      title: Text(S.current.confirmDeleteAccount2Title),
      content: Text(S.current.confirmDeleteAccount2Body),
      actions: DialogControls.delete(context,
          onDelete: () => Get.back(result: true), onCancel: () => Get.back(result: false)),
    ),
  ).then((res) => res == true);
}

Future<void> awaitDeleteAccountConfirmation<T>(BuildContext context, void Function() onConfirmed) => awaitConfirmation(
    confirmDeleteAccount1<T>(context), () => awaitConfirmation(confirmDeleteAccount2<T>(context), onConfirmed));
