import 'package:dungeon_paper/app/modules/ImportExport/controllers/export_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'import_controller.dart';

class ImportExportController extends GetxController with GetSingleTickerProviderStateMixin {
  late final Rx<TabController> tab;

  @override
  void onInit() {
    super.onInit();
    tab = (TabController(length: 2, vsync: this)..addListener(_refresh)).obs;
  }

  @override
  void dispose() {
    super.dispose();
    tab.value.removeListener(_refresh);
  }

  void Function()? get doExport => Get.find<ExportController>().getDoExport();
  void Function()? get doImport => Get.find<ImportController>().getDoImport();

  void _refresh() {
    tab.refresh();
  }
}

abstract class ImportExportSelectionData {
  void toggle<T>(T item, bool state);
  void toggleAll<T>(bool state);
  bool isSelected<T>(T item);

  List<T> listByType<T>();
}
