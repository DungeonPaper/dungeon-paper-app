import 'package:get/get.dart';

import '../controllers/roll_dice_controller.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class RollDiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RollDiceController>(
      RollDiceController(),
    );
  }
}
