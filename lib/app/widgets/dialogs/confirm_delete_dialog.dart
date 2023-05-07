import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/dialog_utils.dart';

class _DeleteDialog extends ConfirmationDialog<DeleteDialogOptions> {
  @override
  Widget createConfirmation<T>(BuildContext context, options) {
    return AlertDialog(
      title: Text(S.current.confirmDeleteTitle(S.current.entity(T))),
      content: Text(
        S.current.confirmDeleteBody(S.current.entity(T), options.entityName),
      ),
      actions: DialogControls.delete(context,
          onDelete: () => Get.back(result: true), onCancel: () => Get.back(result: false)),
    );
  }
}

class DeleteDialogOptions {
  final String entityName;

  DeleteDialogOptions({required this.entityName});
}

final deleteDialog = _DeleteDialog();
