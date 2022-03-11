import 'package:dungeon_paper/app/data/models/gear_choice.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/services/class_service.dart';
import 'package:dungeon_paper/core/http/api.dart';
import 'package:dungeon_paper/core/http/api_requests/search.dart';
import 'package:dungeon_world_data/gear_option.dart';
import 'package:dungeon_world_data/item.dart';
import 'package:get/get.dart';

import '../../../data/models/character_class.dart';

class CharClassSelectController extends GetxController {
  final selectedClass = Rx<CharacterClass?>(null);
  final availableClasses = <CharacterClass>[].obs;
  final _validCache = false.obs;
  final loading = true.obs;

  bool get _isValid => selectedClass.value != null;
  bool get isValid => _validCache.value;

  @override
  void onInit() {
    super.onInit();

    final ctrl = Get.find<ClassService>();
    ctrl.all.listen((map) => getClasses());
    getClasses();
  }

  void updateClasses(Map<String, CharacterClass> classes) {
    availableClasses.clear();
    availableClasses.addAll(classes.values);
  }

  void getClasses() async {
    loading.value = true;
    final ctrl = Get.find<ClassService>();
    updateClasses(ctrl.all);
    loading.value = false;
  }

  void setCharClass(CharacterClass cls) {
    selectedClass.value = cls;
  }

  bool validate() {
    return _validCache.value = _isValid;
  }
}
