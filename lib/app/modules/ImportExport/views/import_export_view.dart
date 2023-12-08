import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/import_export_controller.dart';
import 'export_view.dart';
import 'import_view.dart';

class ImportExportView extends GetView<ImportExportController> {
  const ImportExportView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Theme.of(context).colorScheme.onSurface);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.backup.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TabBar(
            controller: controller.tab.value,
            tabs: [
              Tab(child: Text(tr.backup.exporting.title, style: textStyle)),
              Tab(child: Text(tr.backup.importing.title, style: textStyle)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tab.value,
              children: const [
                ExportView(),
                ImportView(),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Obx(
        () => AdvancedFloatingActionButton.extended(
          label: Text(controller.tab.value.index == 0 ? tr.backup.exporting.button : tr.backup.importing.button),
          icon: Icon(controller.tab.value.index == 0 ? Icons.upload : Icons.download),
          onPressed: controller.tab.value.index == 0 ? controller.doExport : controller.doImport,
        ),
      ),
    );
  }
}
