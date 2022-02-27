import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/char_class_select_controller.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_roll_stats_controller.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_info_controller.dart';
import 'package:get/get.dart';

import '../controllers/create_character_page_controller.dart';

class CreateCharacterPageBinding extends Bindings {
  @override
  void dependencies() {
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
