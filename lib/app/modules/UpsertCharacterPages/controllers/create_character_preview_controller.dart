import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/create_character_page_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:get/get.dart';

class CreateCharacterPreviewController extends GetxController {
  Character get char => Get.find<CreateCharacterPageController>().char.value;

  final expansions = List.filled(1, false).obs;

  createChar() {
    Get.find<CharacterService>().createCharacter(char, switchToCharacter: true);
    Get.offAllNamed(Routes.home);
  }
}
