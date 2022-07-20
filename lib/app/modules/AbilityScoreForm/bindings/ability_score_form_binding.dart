import 'package:get/get.dart';

import '../controllers/ability_score_form_controller.dart';

class AbilityScoreFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbilityScoreFormController>(
      () => AbilityScoreFormController(),
    );
  }
}
