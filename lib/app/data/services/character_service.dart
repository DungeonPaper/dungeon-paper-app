import 'dart:math';

import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/character.dart';
import '../models/character_class.dart';
import '../models/character_stats.dart';
import '../models/meta.dart';
import '../models/move.dart';
import '../models/spell.dart';

class CharacterService extends GetxService {
  final all = <String, Character>{}.obs;
  final _current = Rx<String?>(null);

  final _pageController = PageController(initialPage: 1).obs;

  PageController get pageController => _pageController.value;

  Character? get current => _current.value != null ? all[_current.value] : null;

  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<CharacterService> init() async {
    pageController.addListener(() {
      _current.refresh();
    });
    var json = await StorageHandler.instance.getAllItems('characters');
    var list = json.map((c) => Character.fromJson(c));

    all.addAll(Map.fromIterable(list, key: (c) => c.key));

    if (all.isNotEmpty) {
      // TODO use value from user or shared prefs
      _current.value = all.keys.first;
    }

    return this;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}

  void updateCharacter(Character? character) {
    // (StorageHandler.instance.delegate as LocalStorageDelegate).storage.collection('characters');
    if (character != null) {
      all[character.key] = character;
      StorageHandler.instance.create('characters', character.key, character.toJson());
      _current.value ??= character.key;
      debugPrint('Updated char: ${character.key}');
      debugPrint(character.toRawJson());
    }
  }

  debugUpdateCharData() {
    final char = current;
    updateCharacter(
      Character.empty().copyWith(
        key: char?.key,
        displayName: 'Traveler',
        characterClass:
            (char?.characterClass ?? CharacterClass.empty()).copyInheritedWith(name: 'Druid'),
        stats: (char?.stats ?? CharacterStats(level: 1, currentHp: 20, currentExp: 0, armor: 0))
            .copyWith(currentExp: Random().nextInt(7)),
        moves: [
          Move(
            meta: Meta.version(1),
            favorited: true,
            key: 'test_move',
            name: 'Test Move',
            description:
                'Interdum natoque aptent auctor magna felis libero lectus luctus dictum fermentum,'
                ' massa magnis vitae hendrerit ornare arcu aliquet donec. Ex per duis '
                'suspendisse litora rutrum etiam praesent facilisi ante sagittis pulvinar, '
                'lectus elementum lorem diam vel vestibulum fusce erat potenti leo mi, mus '
                'egestas pretium torquent sociosqu purus hendrerit condimentum dui fermentum.',
            explanation:
                'Scelerisque finibus arcu torquent montes felis pharetra tincidunt dis gravida '
                'parturient adipiscing praesent, vehicula porta vel class iaculis semper ac '
                'tristique lorem velit. Maximus per hendrerit dapibus volutpat non fusce cras, '
                'pretium malesuada proin molestie tellus sodales aenean dui, senectus convallis '
                'varius quam fermentum faucibus.',
            dice: [dw.Dice.fromJson('2d6+DEX')],
            classKeys: ['druid'],
            tags: [
              dw.Tag.fromJson({'name': 'source', 'value': 'casraf'}),
              dw.Tag.fromJson({'name': 'language', 'value': 'EN'})
            ],
            category: MoveCategory.basic,
          ),
          Move(
            meta: Meta.version(1),
            favorited: true,
            key: 'test_move_2',
            name: 'Test Move 2',
            description:
                'Nascetur id malesuada nec aenean quam vel sit, at non accumsan sem dolor risus '
                'pretium eget, elementum curae iaculis eleifend magnis augue. Lectus congue '
                'pharetra posuere et ultricies laoreet euismod phasellus ridiculus, quisque massa '
                'tempus fusce mollis fames curabitur arcu, iaculis ornare morbi integer odio '
                'ullamcorper duis natoque.',
            explanation:
                'Etiam vulputate montes ullamcorper arcu consectetur turpis fames, nec nunc orci '
                'ultrices porttitor elementum, primis duis suscipit justo dui tellus. Hendrerit '
                'pharetra tristique etiam mollis faucibus quam donec enim, ipsum ridiculus augue '
                'laoreet commodo lacinia placerat bibendum curabitur, porttitor purus nascetur '
                'vestibulum dis lobortis et.',
            dice: [],
            classKeys: ['druid'],
            tags: [
              dw.Tag.fromJson({'name': 'source', 'value': 'casraf'}),
              dw.Tag.fromJson({'name': 'language', 'value': 'EN'})
            ],
            category: MoveCategory.advanced1,
          ),
          Move(
            meta: Meta.version(1),
            favorited: true,
            key: 'test_move_3',
            name: 'Test Move 3',
            description:
                'Magna habitasse vitae netus mattis bibendum pulvinar, feugiat tortor etiam lorem '
                'ultricies at eget, risus volutpat tellus ornare pharetra. Mi parturient sapien '
                'sollicitudin proin tincidunt purus duis dictumst, quis dis metus ad nisl tortor '
                'consequat justo, imperdiet quam felis fermentum class placerat cursus, senectus '
                'viverra suspendisse lobortis enim nibh pellentesque.',
            explanation:
                'Fermentum conubia sit maximus torquent nunc cras primis tempor, eget efficitur '
                'lobortis convallis libero turpis commodo laoreet praesent, phasellus imperdiet '
                'elit facilisi hendrerit est lacinia. Eget condimentum nulla diam nullam mauris '
                'magnis odio, sodales dolor bibendum quam porta adipiscing.',
            dice: [],
            classKeys: ['druid'],
            tags: [
              dw.Tag.fromJson({'name': 'source', 'value': 'casraf'}),
              dw.Tag.fromJson({'name': 'language', 'value': 'EN'})
            ],
            category: MoveCategory.special,
          ),
        ],
        spells: [
          Spell(
            key: 'test_spell_1',
            name: 'Test Spell 1',
            meta: Meta.version(1),
            description: 'Facilisis tincidunt inceptos habitant dis aptent mattis hendrerit nisi '
                'cursus, maximus at hac sem aliquet dui fringilla platea fames tortor, dictum integer '
                'mauris erat sagittis magna accumsan morbi. Ornare class viverra cubilia ridiculus '
                'cras inceptos montes nisl congue maecenas rutrum, nascetur mattis dignissim porttitor '
                'praesent adipiscing sed odio non auctor.',
            explanation: 'Per elementum quisque habitasse malesuada eleifend porttitor '
                'tincidunt pellentesque est, nisi felis class habitant tristique metus finibus. '
                'Lobortis nullam egestas arcu faucibus malesuada nunc congue, luctus pharetra leo '
                'hendrerit cubilia purus libero nisl, habitant in duis diam inceptos nec.',
            tags: [
              dw.Tag.fromJson({'name': 'source', 'value': 'casraf'}),
              dw.Tag.fromJson({'name': 'language', 'value': 'EN'})
            ],
            dice: [dw.Dice.fromJson('1d4')],
            classKeys: ['druid'],
            prepared: true,
          ),
          Spell(
            key: 'test_spell_2',
            name: 'Test Spell 2',
            meta: Meta.version(1),
            description: 'Facilisis tincidunt inceptos habitant dis aptent mattis hendrerit nisi '
                'cursus, maximus at hac sem aliquet dui fringilla platea fames tortor, dictum integer '
                'mauris erat sagittis magna accumsan morbi. Ornare class viverra cubilia ridiculus '
                'cras inceptos montes nisl congue maecenas rutrum, nascetur mattis dignissim porttitor '
                'praesent adipiscing sed odio non auctor.',
            explanation: 'Per elementum quisque habitasse malesuada eleifend porttitor '
                'tincidunt pellentesque est, nisi felis class habitant tristique metus finibus. '
                'Lobortis nullam egestas arcu faucibus malesuada nunc congue, luctus pharetra leo '
                'hendrerit cubilia purus libero nisl, habitant in duis diam inceptos nec.',
            tags: [
              dw.Tag.fromJson({'name': 'source', 'value': 'casraf'}),
              dw.Tag.fromJson({'name': 'language', 'value': 'EN'})
            ],
            dice: [],
            classKeys: ['druid'],
            prepared: true,
          ),
          Spell(
            key: 'test_spell_3',
            name: 'Test Spell 3',
            meta: Meta.version(1),
            description: 'Facilisis tincidunt inceptos habitant dis aptent mattis hendrerit nisi '
                'cursus, maximus at hac sem aliquet dui fringilla platea fames tortor, dictum integer '
                'mauris erat sagittis magna accumsan morbi. Ornare class viverra cubilia ridiculus '
                'cras inceptos montes nisl congue maecenas rutrum, nascetur mattis dignissim porttitor '
                'praesent adipiscing sed odio non auctor.',
            explanation: 'Per elementum quisque habitasse malesuada eleifend porttitor '
                'tincidunt pellentesque est, nisi felis class habitant tristique metus finibus. '
                'Lobortis nullam egestas arcu faucibus malesuada nunc congue, luctus pharetra leo '
                'hendrerit cubilia purus libero nisl, habitant in duis diam inceptos nec.',
            tags: [
              dw.Tag.fromJson({'name': 'source', 'value': 'casraf'}),
              dw.Tag.fromJson({'name': 'language', 'value': 'EN'})
            ],
            dice: [dw.Dice.fromJson('1d4')],
            classKeys: ['druid'],
            prepared: true,
          ),
        ],
      ),
    );
  }
}
