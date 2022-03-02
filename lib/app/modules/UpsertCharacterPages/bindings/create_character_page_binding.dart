import '../controllers/char_class_select_controller.dart';
import '../controllers/character_background_controller.dart';
import '../controllers/character_gear_controller.dart';
import '../controllers/character_moves_spells_controller.dart';
import '../controllers/character_roll_stats_controller.dart';
import '../controllers/character_info_controller.dart';
import '../controllers/create_character_preview_controller.dart';
import 'package:get/get.dart';

import '../controllers/create_character_page_controller.dart';

class CreateCharacterPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateCharacterPreviewController>(
      () => CreateCharacterPreviewController(),
    );
    Get.lazyPut<CharacterBackgroundController>(
      () => CharacterBackgroundController(),
    );
    Get.lazyPut<CharacterGearController>(
      () => CharacterGearController(),
    );
    Get.lazyPut<CharacterMovesSpellsController>(
      () => CharacterMovesSpellsController(),
    );
    Get.lazyPut<CharacterRollStatsController>(
      () => CharacterRollStatsController(),
    );
    Get.lazyPut<CharClassSelectController>(
      () => CharClassSelectController(),
    );
    Get.lazyPut<CharacterInfoController>(
      () => CharacterInfoController(),
    );
    Get.lazyPut<CreateCharacterPageController>(
      () => CreateCharacterPageController(),
    );
  }
}
