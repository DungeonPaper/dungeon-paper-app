import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/modules/ImportExport/controllers/export_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'import_controller.dart';

// TODO remove?
class ImportExportController extends ChangeNotifier {
  void Function()? get doExport => Get.find<ExportController>().getDoExport();
  void Function()? get doImport => Get.find<ImportController>().getDoImport();
}

abstract class ImportExportSelectionData {
  void toggle<T extends WithMeta>(T item, bool state);
  void toggleAll<T extends WithMeta>(bool state);
  bool isSelected<T extends WithMeta>(T item);

  List<T> listByType<T extends WithMeta>();
}

