import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/import_export_controller.dart';
import 'export_view.dart';
import 'import_view.dart';

class ImportExportView extends StatefulWidget {
  const ImportExportView({super.key});

  @override
  State<ImportExportView> createState() => _ImportExportViewState();
}

class _ImportExportViewState extends State<ImportExportView>
    with SingleTickerProviderStateMixin {
  late final TabController tab;

  @override
  void initState() {
    super.initState();
    tab = TabController(length: 2, vsync: this);
  }

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
            controller: tab,
            tabs: [
              Tab(child: Text(tr.backup.exporting.title, style: textStyle)),
              Tab(child: Text(tr.backup.importing.title, style: textStyle)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tab,
              children: const [
                ExportView(),
                ImportView(),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Consumer<ImportExportController>(
        builder: (context, controller, _) =>
            AdvancedFloatingActionButton.extended(
          label: Text(tab.index == 0
              ? tr.backup.exporting.button
              : tr.backup.importing.button),
          icon: Icon(tab.index == 0 ? Icons.upload : Icons.download),
          onPressed: tab.index == 0
              ? () => controller.doExport(context)
              : () => controller.doImport(context),
        ),
      ),
    );
  }
}

