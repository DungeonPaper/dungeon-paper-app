import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/models/character.dart';

class HomeController extends GetxController {
  final all = <String, Character>{}.obs;
  final _current = Rx<String?>(null);

  final _pageController = PageController(initialPage: 1).obs;

  PageController get pageController => _pageController.value;

  Character? get current => _current.value != null ? all[_current.value] : null;

  @override
  void onInit() async {
    super.onInit();
    pageController.addListener(() {
      update();
    });
    var json = await StorageHandler.instance.getAllItems('characters');
    var list = json.map((c) => Character.fromJson(c));

    all.addAll(Map.fromIterable(list, key: (c) => c.key));

    if (all.isNotEmpty) {
      _current.value = all.keys.first;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void updateCharacter(Character? character) {
    // (StorageHandler.instance.delegate as LocalStorageDelegate).storage.collection('characters');
    if (character != null) {
      all[character.key] = character;
      StorageHandler.instance.create('characters', character.key, character.toJson());
      _current.value ??= character.key;
    }
  }
}
