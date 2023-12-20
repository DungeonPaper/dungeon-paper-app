import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/modules/ImportExport/controllers/export_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'import_controller.dart';

// TODO remove?
class ImportExportController extends ChangeNotifier {
  void Function()? doExport(BuildContext context) => Provider.of<ExportController>(context).getDoExport();
  void Function()? doImport(BuildContext context) => Provider.of<ImportController>(context).getDoImport(context);
}

abstract class ImportExportSelectionData {
  void toggle<T extends WithMeta>(T item, bool state);
  void toggleAll<T extends WithMeta>(bool state);
  bool isSelected<T extends WithMeta>(T item);

  List<T> listByType<T extends WithMeta>();
}

