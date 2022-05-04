import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:get/get.dart';

class CreateCharacterController extends GetxController {
  final name = ''.obs;
  final avatarUrl = ''.obs;
  final characterClass = Rx<CharacterClass?>(null);

  final dirty = false.obs;

  setBasicInfo(String name, String avatar) {
    this.name.value = name;
    avatarUrl.value = avatar;
    setDirty();
  }

  setClass(CharacterClass cls) {
    characterClass.value = cls;
    setDirty();
  }

  void setDirty() {
    dirty.value = true;
  }
}
