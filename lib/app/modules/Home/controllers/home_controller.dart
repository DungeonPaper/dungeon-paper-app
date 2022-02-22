import 'dart:math';

import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/models/character.dart';
import '../../../data/models/character_class.dart';
import '../../../data/models/character_stats.dart';
import '../../../data/models/meta.dart';
import '../../../data/models/move.dart';

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

  debugUpdateCharData() {
    final char = current;
    updateCharacter(
      Character.empty().copyWith(
        key: char?.key,
        displayName: "Traveler",
        characterClass:
            (char?.characterClass ?? CharacterClass.empty()).copyInheritedWith(name: "Druid"),
        stats: (char?.stats ?? CharacterStats(level: 1, currentHp: 20, currentExp: 0, armor: 0))
            .copyWith(currentExp: Random().nextInt(7)),
        moves: [
          Move(
            meta: Meta.version(1),
            favorited: true,
            key: 'test_move',
            name: "Test Move",
            description:
                "Interdum natoque aptent auctor magna felis libero lectus luctus dictum fermentum,"
                " massa magnis vitae hendrerit ornare arcu aliquet donec. Ex per duis "
                "suspendisse litora rutrum etiam praesent facilisi ante sagittis pulvinar, "
                "lectus elementum lorem diam vel vestibulum fusce erat potenti leo mi, mus "
                "egestas pretium torquent sociosqu purus hendrerit condimentum dui fermentum.",
            explanation:
                "Scelerisque finibus arcu torquent montes felis pharetra tincidunt dis gravida "
                "parturient adipiscing praesent, vehicula porta vel class iaculis semper ac "
                "tristique lorem velit. Maximus per hendrerit dapibus volutpat non fusce cras, "
                "pretium malesuada proin molestie tellus sodales aenean dui, senectus convallis "
                "varius quam fermentum faucibus.",
            dice: [dw.Dice.fromJson("2d6+DEX")],
            classKeys: ["druid"],
            tags: [
              dw.Tag.fromJson({'name': "source", "value": "casraf"}),
              dw.Tag.fromJson({'name': "language", "value": "EN"})
            ],
            category: MoveCategory.basic,
          ),
          Move(
            meta: Meta.version(1),
            favorited: true,
            key: 'test_move_2',
            name: "Test Move 2",
            description:
                "Nascetur id malesuada nec aenean quam vel sit, at non accumsan sem dolor risus "
                "pretium eget, elementum curae iaculis eleifend magnis augue. Lectus congue "
                "pharetra posuere et ultricies laoreet euismod phasellus ridiculus, quisque massa "
                "tempus fusce mollis fames curabitur arcu, iaculis ornare morbi integer odio "
                "ullamcorper duis natoque.",
            explanation:
                "Etiam vulputate montes ullamcorper arcu consectetur turpis fames, nec nunc orci "
                "ultrices porttitor elementum, primis duis suscipit justo dui tellus. Hendrerit "
                "pharetra tristique etiam mollis faucibus quam donec enim, ipsum ridiculus augue "
                "laoreet commodo lacinia placerat bibendum curabitur, porttitor purus nascetur "
                "vestibulum dis lobortis et.",
            dice: [dw.Dice.fromJson("2d6+DEX")],
            classKeys: ["druid"],
            tags: [
              dw.Tag.fromJson({'name': "source", "value": "casraf"}),
              dw.Tag.fromJson({'name': "language", "value": "EN"})
            ],
            category: MoveCategory.basic,
          ),
        ],
      ),
    );
  }
}
