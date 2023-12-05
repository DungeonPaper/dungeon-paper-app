import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/dialog_utils.dart';

class _DeleteDialog extends ConfirmationDialog<DeleteDialogOptions> {
  @override
  Widget createConfirmation<T>(
      BuildContext context, DeleteDialogOptions options) {
    return AlertDialog(
      title: Text(tr.dialogs.confirmations.delete.title(options.entityKind)),
      content: Text(
        tr.dialogs.confirmations.delete
            .body(options.entityKind, options.entityName),
      ),
      actions: DialogControls.delete(
        context,
        onDelete: () => Get.back(result: true),
        onCancel: () => Get.back(result: false),
      ),
    );
  }
}

class DeleteDialogOptions {
  final String entityKind;
  final String entityName;

  DeleteDialogOptions({required this.entityKind, required this.entityName});
}

final deleteDialog = _DeleteDialog();

