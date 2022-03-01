import 'package:dungeon_paper/app/data/models/gear_choice.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/char_class_select_controller.dart';
import 'package:dungeon_world_data/gear_option.dart';
import 'package:get/get.dart';

class CharacterGearController extends GetxController {
  final _selectedOptions = <GearOption>[];
  final _availableGear = <GearChoice>[].obs;
  final _loading = true.obs;

  List<GearOption> get selectedOptions => _selectedOptions;
  List<GearChoice> get availableGear => _availableGear;
  bool get loading => _loading.value;

  @override
  void onInit() {
    super.onInit();
    getGear();
  }

  void getGear() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final CharClassSelectController ctrl = Get.find();
    _availableGear.value = ctrl.selectedClass!.gearChoices;
    _loading.value = false;
  }

  void toggleSelect(GearOption option) {
    _selectedOptions.add(option);
  }
}

class CharGear {
  final List<GearOption> options;

  CharGear({required this.options});
}
