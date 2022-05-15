import 'package:get/get.dart';

import '../controllers/starting_gear_form_controller.dart';

class StartingGearFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StartingGearFormController>(
      StartingGearFormController(),
    );
  }
}
