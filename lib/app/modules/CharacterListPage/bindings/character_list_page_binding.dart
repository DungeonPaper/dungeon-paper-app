import 'package:get/get.dart';

import '../controllers/character_list_page_controller.dart';

class CharacterListPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CharacterListPageController>(
      () => CharacterListPageController(),
    );
  }
}
