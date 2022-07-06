import 'package:get/get.dart';

import '../controllers/select_character_theme_controller.dart';

class SelectCharacterThemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectCharacterThemeController>(
      () => SelectCharacterThemeController(),
    );
  }
}
