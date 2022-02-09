import 'package:dungeon_paper/data/models/character_class.dart';
import 'package:get/get.dart';

import '../../../../data/models/character.dart';

class CreateCharacterPageController extends GetxController {
  final displayName = ''.obs;
  final bioDesc = ''.obs;
  final avatarUrl = ''.obs;
  // final cls = Rx<CharacterClass>();

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  void updateCharInfo({
    required String displayName,
    required String bioDesc,
    required String avatarUrl,
  }) {
    this.displayName.value = displayName;
    this.bioDesc.value = bioDesc;
    this.avatarUrl.value = avatarUrl;
  }

  @override
  void onClose() {}
}
