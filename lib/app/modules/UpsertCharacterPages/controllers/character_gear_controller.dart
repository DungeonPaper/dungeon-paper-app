import 'dart:async';

import 'package:dungeon_paper/app/data/models/gear_choice.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/char_class_select_controller.dart';
import 'package:get/get.dart';

class CharacterGearController extends GetxController {
  final selectedOptions = <GearSelection>[].obs;
  final availableGear = <GearChoice>[].obs;
  final _loading = true.obs;
  final sub = Rx<StreamSubscription?>(null);

  bool get loading => _loading.value;

  @override
  void onInit() {
    super.onInit();
    getGear();
    sub.value = Get.find<CharClassSelectController>().selectedClass.listen(clearSelection);
  }

  void clearSelection(dynamic cls) {
    selectedOptions.clear();
  }

  void getGear() async {
    // await Future.delayed(const Duration(milliseconds: 300));
    final ctrl = Get.find<CharClassSelectController>();
    availableGear.value = ctrl.selectedClass.value!.gearChoices;
    _loading.value = false;
  }

  void toggleSelect(GearSelection selection) {
    final found = selectedOptions.firstWhereOrNull((item) => item.key == selection.key);
    if (found == null) {
      selectedOptions.add(selection);
    } else {
      selectedOptions.remove(found);
    }
  }

  bool isSelected(GearSelection selection) =>
      selectedOptions.indexWhere((item) => item.key == selection.key) != -1;

  CharGear get charGear => CharGear(selections: selectedOptions);

  @override
  void onClose() {
    sub.value?.cancel();
    super.onClose();
  }
}

class CharGear {
  final List<GearSelection> selections;

  CharGear({required this.selections});
}
