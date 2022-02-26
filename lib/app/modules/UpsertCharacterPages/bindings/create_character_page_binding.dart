import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/char_class_select_controller.dart';
import 'package:get/get.dart';

import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/char_info_controller.dart';

import '../controllers/create_character_page_controller.dart';

class CreateCharacterPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CharClassSelectController>(
      () => CharClassSelectController(),
    );
    Get.lazyPut<CharInfoController>(
      () => CharInfoController(),
    );
    Get.lazyPut<CreateCharacterPageController>(
      () => CreateCharacterPageController(),
    );
  }
}
