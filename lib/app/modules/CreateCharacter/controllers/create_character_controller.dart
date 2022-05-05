import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:get/get.dart';

class CreateCharacterController extends GetxController {
  final name = ''.obs;
  final avatarUrl = ''.obs;
  final characterClass = Rx<CharacterClass?>(null);
  final rollStats =
      RollStats.dungeonWorld(dex: 10, str: 10, wis: 10, con: 10, intl: 10, cha: 10).obs;

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

  setRollStats(RollStats stats) {
    rollStats.value = stats;
    setDirty();
  }

  void setDirty() {
    dirty.value = true;
  }
}
