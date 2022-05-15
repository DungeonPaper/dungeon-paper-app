import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/gear_choice.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:get/get.dart';

class StartingGearFormController extends GetxController {
  final availableGear = <GearChoice>[].obs;
  final dirty = false.obs;

  late final RxList<GearSelection> selectedOptions;
  late final CharacterClass characterClass;
  late final void Function(List<GearSelection> selectedOptions) onChanged;

  @override
  void onReady() {
    super.onReady();
    final StartingGearFormArguments args = Get.arguments;
    selectedOptions = args.selectedOptions.obs;
    characterClass = args.characterClass;
    onChanged = args.onChanged;
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
}

class StartingGearFormArguments {
  final List<GearSelection> selectedOptions;
  final CharacterClass characterClass;
  final void Function(List<GearSelection> selectedOptions) onChanged;

  StartingGearFormArguments({
    required this.selectedOptions,
    required this.characterClass,
    required this.onChanged,
  });
}
