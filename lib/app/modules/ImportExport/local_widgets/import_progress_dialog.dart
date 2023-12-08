import 'package:dungeon_paper/app/modules/ImportExport/controllers/import_controller.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImportProgressDialog extends GetView<ImportController> {
  const ImportProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final completedCount =
            controller.selectionsCount - controller.leftCount.value;
        final totalCount = controller.selectionsCount;
        return SimpleDialog(
          title: Text(tr.backup.importing.progress.title),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 32)
                  .copyWith(top: 8),
          children: [
            Text(
              tr.backup.importing.progress.processing(
                tr.entityPlural(controller.importStep.value!),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value:
                        1 - controller.leftCount / controller.selectionsCount,
                  ),
                ),
                const SizedBox(width: 16),
                Text('$completedCount / $totalCount'),
              ],
            )
          ],
        );
      },
    );
  }
}
