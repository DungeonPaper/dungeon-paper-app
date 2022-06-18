import 'package:get/get.dart';

import '../controllers/hp_dialog_controller.dart';

class HPDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HPDialogController>(
      () => HPDialogController(),
    );
  }
}
