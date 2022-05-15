import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:get/get.dart';

import '../controllers/ability_scores_form_controller.dart';

class AbilityScoresFormBinding extends Bindings {
  final AbilityScores abilityScores;

  AbilityScoresFormBinding({required this.abilityScores});
  @override
  void dependencies() {
    Get.put<AbilityScoresFormController>(
      AbilityScoresFormController(abilityScores: abilityScores),
    );
  }
}
