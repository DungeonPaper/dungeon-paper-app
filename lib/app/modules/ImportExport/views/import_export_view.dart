import 'package:dungeon_paper/app/modules/ImportExport/views/export_view.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/import_export_controller.dart';

class ImportExportView extends GetView<ImportExportController> {
  const ImportExportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Theme.of(context).colorScheme.onSurface);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.importExportTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TabBar(
            controller: controller.tab,
            tabs: [
              Tab(child: Text(S.current.export, style: textStyle)),
              Tab(child: Text(S.current.import, style: textStyle)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tab,
              children: [
                const ExportView(),
                Center(child: Text(S.current.import)),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(controller.tab.index == 0 ? S.current.export : S.current.import),
        backgroundColor: DwColors.success,
        icon: Icon(controller.tab.index == 0 ? Icons.upload : Icons.download),
        onPressed: controller.tab.index == 0 ? controller.doExport : controller.doImport,
      ),
    );
  }
}
