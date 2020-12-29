import 'package:dungeon_paper/src/scaffolds/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'export_view.dart';
import 'import_view.dart';

class BackupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: Text('Import and Export Data'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ExpansionTile(
                tilePadding: const EdgeInsets.all(16),
                leading: Icon(
                  Icons.file_upload,
                  size: 30,
                  color: Get.theme.colorScheme.onSurface,
                ),
                title: Text(
                  'Export',
                  style: Get.theme.textTheme.headline5,
                ),
                children: [ExportView()],
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: ExpansionTile(
                tilePadding: const EdgeInsets.all(16),
                leading: Icon(
                  Icons.file_download,
                  size: 30,
                  color: Get.theme.colorScheme.onSurface,
                ),
                title: Text(
                  'Import',
                  style: Get.theme.textTheme.headline5,
                ),
                children: [ImportView()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
