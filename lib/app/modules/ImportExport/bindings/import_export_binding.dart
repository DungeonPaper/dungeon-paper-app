import 'package:get/get.dart';

import '../controllers/export_controller.dart';
import '../controllers/import_controller.dart';
import '../controllers/import_export_controller.dart';

class ImportExportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImportExportController>(
      () => ImportExportController(),
    );
    Get.lazyPut<ExportController>(
      () => ExportController(),
    );
    Get.lazyPut<ImportController>(
      () => ImportController(),
    );
  }
}
