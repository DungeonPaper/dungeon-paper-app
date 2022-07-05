import 'package:get/get.dart';

import '../controllers/migration_controller.dart';

class MigrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MigrationController>(
      () => MigrationController(),
    );
  }
}
