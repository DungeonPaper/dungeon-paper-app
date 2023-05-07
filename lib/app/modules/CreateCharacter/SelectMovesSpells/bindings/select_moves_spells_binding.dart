import 'package:get/get.dart';

import '../controllers/select_moves_spells_controller.dart';

class SelectMovesSpellsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SelectMovesSpellsController>(
      SelectMovesSpellsController(),
    );
  }
}
