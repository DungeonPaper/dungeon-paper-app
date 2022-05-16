import 'package:get/get.dart';

import '../controllers/bio_form_controller.dart';

class BioFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BioFormController>(
      () => BioFormController(),
    );
  }
}
