import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:get/get.dart';

import '../controllers/roll_stats_form_controller.dart';

class RollStatsFormBinding extends Bindings {
  final RollStats rollStats;

  RollStatsFormBinding({required this.rollStats});
  @override
  void dependencies() {
    Get.put<RollStatsFormController>(
      RollStatsFormController(rollStats: rollStats),
    );
  }
}
