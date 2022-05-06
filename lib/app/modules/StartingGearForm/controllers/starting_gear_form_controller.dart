import 'dart:async';

import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/gear_choice.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:get/get.dart';

class StartingGearFormController extends GetxController {
  final RxList<GearSelection> selectedOptions;
  final availableGear = <GearChoice>[].obs;
  final CharacterClass characterClass;
  final dirty = false.obs;

  StartingGearFormController({
    required this.characterClass,
    List<GearSelection>? selections,
  }) : selectedOptions = (selections ?? []).obs;

  @override
  void onInit() {
    super.onInit();
    getGear();
  }

  void onChangeClass(cls) {
    selectedOptions.clear();
    getGear();
  }

  void getGear() async {
    availableGear.value = characterClass.gearChoices;
  }

  void toggleSelect(GearSelection selection) {
    dirty.value = true;
    final found = selectedOptions.firstWhereOrNull((item) => item.key == selection.key);
    if (found == null) {
      selectedOptions.add(selection);
    } else {
      selectedOptions.remove(found);
    }
  }

  bool isSelected(GearSelection selection) =>
      selectedOptions.firstWhereOrNull((item) => keyFor(item) == keyFor(selection)) != null;

  @override
  void onClose() {
    super.onClose();
  }
}
