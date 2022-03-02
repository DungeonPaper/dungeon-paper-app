import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/create_character_page_controller.dart';
import 'package:get/get.dart';

class CreateCharacterPreviewController extends GetxController {
  Character get char => Get.find<CreateCharacterPageController>().char.value;
}
