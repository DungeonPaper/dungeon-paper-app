import 'package:dungeon_paper/app/modules/ImportExport/controllers/import_controller.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImportProgressDialog extends GetView<ImportController> {
  const ImportProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: () async => true,
      onWillPop: () async => false,
      child: Obx(
        () => SimpleDialog(
          // TODO intl
          title: Text('Importing'),
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 32).copyWith(top: 8),
          children: [
            // TODO intl
            Text('Processing ' + S.current.entityPlural(controller.importStep.value!) + '...'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 1 - controller.leftCount / controller.selectionsCount,
                  ),
                ),
                const SizedBox(width: 16),
                Text('${controller.leftCount} / ${controller.selectionsCount}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
