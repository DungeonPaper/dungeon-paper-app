import 'package:get/get.dart';

import '../../../data/models/character.dart';

class CharacterListPageController extends GetxController {
  final characters = <Character>[].obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}

  void addCharacter(Character char) {
    characters.add(char);
    characters.refresh();
  }
}
