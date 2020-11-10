import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
import 'package:flutter/material.dart';
import 'export_view.dart';
import 'import_view.dart';

class BackupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithElevation(
      title: Text('Import and Export Characters'),
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
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                title: Text(
                  'Export',
                  style: Theme.of(context).textTheme.headline5,
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
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                title: Text(
                  'Import',
                  style: Theme.of(context).textTheme.headline5,
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
