import 'package:dungeon_paper/src/molecules/export_characters_view.dart';
import 'package:dungeon_paper/src/molecules/import_characters_view.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
import 'package:flutter/material.dart';

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
                title: Text(
                  'Export',
                  style: Theme.of(context).textTheme.headline5,
                ),
                children: [ExportCharactersView()],
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: ExpansionTile(
                tilePadding: const EdgeInsets.all(16),
                title: Text(
                  'Import',
                  style: Theme.of(context).textTheme.headline5,
                ),
                children: [ImportCharactersView()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}