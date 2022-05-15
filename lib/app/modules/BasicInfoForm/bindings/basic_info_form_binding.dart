import 'package:get/get.dart';

import '../controllers/basic_info_form_controller.dart';

class BasicInfoFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BasicInfoFormController>(
      () => BasicInfoFormController(),
    );
  }
}
