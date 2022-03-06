import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:get/get.dart';

import '../../../data/models/character.dart';

class CharacterListPageController extends GetxController {
  final characters = <Character>[].obs;

  @override
  void onInit() async {
    super.onInit();
    characters.addAll((await StorageHandler.instance.getCollection('characters'))
        .map((c) => Character.fromJson(c)));
    characters.refresh();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}

  void addCharacter(Character char) {
    characters.add(char);
    StorageHandler.instance.create('characters', char.key, char.toJson());
    characters.refresh();
  }
}
