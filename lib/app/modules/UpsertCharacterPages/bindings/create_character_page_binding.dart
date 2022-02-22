import 'package:get/get.dart';

import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/char_info_controller.dart';

import '../controllers/create_character_page_controller.dart';

class CreateCharacterPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CharInfoController>(
      () => CharInfoController(),
    );
    Get.lazyPut<CreateCharacterPageController>(
      () => CreateCharacterPageController(),
    );
  }
}
