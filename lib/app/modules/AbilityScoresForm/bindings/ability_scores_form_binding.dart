import 'package:get/get.dart';

import '../controllers/ability_scores_form_controller.dart';

class AbilityScoresFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AbilityScoresFormController>(
      AbilityScoresFormController(),
    );
  }
}
