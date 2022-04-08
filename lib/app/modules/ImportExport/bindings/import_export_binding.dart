import 'package:get/get.dart';

import '../controllers/import_export_controller.dart';

class ImportExportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImportExportController>(
      () => ImportExportController(),
    );
  }
}
