import 'package:dungeon_paper/app/data/models/gear_choice.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_world_data/gear_option.dart';
import 'package:dungeon_world_data/item.dart';
import 'package:get/get.dart';

import '../../../data/models/character_class.dart';

class CharClassSelectController extends GetxController {
  final selectedClass = Rx<CharacterClass?>(null);
  final availableClasses = <CharacterClass>[].obs;
  final _validCache = false.obs;
  final loading = true.obs;

  bool get _isValid => selectedClass != null;
  bool get isValid => _validCache.value;

  @override
  void onInit() {
    super.onInit();
    getClasses();
  }

  void getClasses() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final gearChoices = [
      GearChoice(
        key: 'choose_own_gear',
        description: 'Choose your own gear that you bought:',
        selections: [
          GearSelection(
            key: 'chain_shirt_and_leather_pants_10_gold',
            description: 'Chain shirt and leather pants + 10 gold',
            options: [
              GearOption(
                key: 'chain_shirt',
                item: Item(
                  key: 'chain_shirt',
                  description: 'Chain shirt',
                  meta: Meta.version(1),
                  name: 'Chain Shirt',
                  tags: [],
                ),
                amount: 1,
              ),
              GearOption(
                key: 'leather_pants',
                item: Item(
                  key: 'leather_pants',
                  description: 'Leather pants',
                  meta: Meta.version(1),
                  name: 'Leather Pants',
                  tags: [],
                ),
                amount: 1,
              ),
            ],
            gold: 10,
          ),
          GearSelection(
            key: 'wooden_shield_and_cloth_pants_20_gold',
            description: 'Wooden shield and cloth pants + 20 gold',
            options: [
              GearOption(
                key: 'wooden_shield',
                item: Item(
                  key: 'wooden_shield',
                  description: 'Wooden shield',
                  meta: Meta.version(1),
                  name: 'Wooden Shield',
                  tags: [],
                ),
                amount: 1,
              ),
              GearOption(
                key: 'cloth_pants',
                item: Item(
                  key: 'cloth_pants',
                  description: 'Cloth pants',
                  meta: Meta.version(1),
                  name: 'Cloth Pants',
                  tags: [],
                ),
                amount: 1,
              ),
            ],
            gold: 10,
          ),
        ],
      ),
      GearChoice(
        key: 'choose_one_weapon',
        description: 'Choose one weapon:',
        selections: [
          GearSelection(
            key: 'your_friends_sword',
            description: "Your friend's sword",
            options: [
              GearOption(
                amount: 1,
                key: 'your_friends_sword',
                item: Item(
                  meta: Meta.version(1),
                  key: 'your_friends_sword',
                  name: "Your friend's sword",
                  description: 'A sword given to you by a loyal friend. It was their own before.',
                  tags: [],
                ),
              )
            ],
            gold: 0,
          ),
          GearSelection(
            key: 'your_friends_axe',
            description: "Your friend's axe",
            options: [
              GearOption(
                key: 'your_friends_axe',
                amount: 1,
                item: Item(
                  meta: Meta.version(1),
                  key: 'your_friends_axe',
                  name: "Your friend's axe",
                  description: 'A axe given to you by a loyal friend. It was their own before.',
                  tags: [],
                ),
              )
            ],
            gold: 0,
          ),
          GearSelection(
            key: 'your_friends_bow',
            description: "Your friend's bow",
            options: [
              GearOption(
                key: 'your_friends_bow',
                amount: 1,
                item: Item(
                  meta: Meta.version(1),
                  key: 'your_friends_bow',
                  name: "Your friend's bow",
                  description: 'A bow given to you by a loyal friend. It was their own before.',
                  tags: [],
                ),
              )
            ],
            gold: 0,
          ),
        ],
      ),
    ];
    availableClasses.value = [
      CharacterClass.empty().copyInheritedWith(
        name: 'Druid',
        gearChoices: gearChoices,
      ),
      CharacterClass.empty().copyInheritedWith(
        name: 'Immolator',
        gearChoices: gearChoices,
      ),
      CharacterClass.empty().copyInheritedWith(
        name: 'Fighter',
        gearChoices: gearChoices,
      ),
    ];
    loading.value = false;
  }

  void setCharClass(CharacterClass cls) {
    selectedClass.value = cls;
  }

  bool validate() {
    return _validCache.value = _isValid;
  }
}
