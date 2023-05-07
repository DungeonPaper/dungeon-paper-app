import 'package:get/get.dart';

import '../controllers/bonds_flags_form_controller.dart';

class BondsFlagsFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BondsFlagsFormController>(
      () => BondsFlagsFormController(),
    );
  }
}
