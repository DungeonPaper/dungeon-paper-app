import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:get/get.dart';

import '../controllers/starting_gear_form_controller.dart';

class StartingGearFormBinding extends Bindings {
  StartingGearFormBinding({
    required this.characterClass,
    required this.selections,
  });

  final CharacterClass characterClass;
  final List<GearSelection> selections;

  @override
  void dependencies() {
    Get.put<StartingGearFormController>(
      StartingGearFormController(characterClass: characterClass, selections: selections),
    );
  }
}
