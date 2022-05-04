import 'package:get/get.dart';

import '../controllers/create_character_controller.dart';

class CreateCharacterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CreateCharacterController>(
      CreateCharacterController(),
    );
  }
}
