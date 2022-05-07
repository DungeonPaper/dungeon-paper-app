import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:get/get.dart';

class CreateCharacterController extends GetxController {
  final name = ''.obs;
  final avatarUrl = ''.obs;
  final characterClass = Rx<CharacterClass?>(null);
  final rollStats =
      RollStats.dungeonWorld(dex: 10, str: 10, wis: 10, con: 10, intl: 10, cha: 10).obs;
  final startingGear = <GearSelection>[].obs;
  final moves = <Move>[].obs;
  final spells = <Spell>[].obs;
  final repo = Get.find<RepositoryService>();

  final dirty = false.obs;

  bool get isValid => [
        name.isNotEmpty,
        characterClass.value != null,
      ].every((element) => element == true);

  List<Item> get items => startingGear.fold(<Item>[], (previousValue, element) {
        return [
          ...previousValue,
          ...element.options.map(
            (e) => Item.fromDwItem(e.item, amount: e.amount),
          )
        ];
      });

  double get coins =>
      startingGear.fold(0, (previousValue, element) => previousValue + element.coins);

  void setBasicInfo(String name, String avatar) {
    this.name.value = name;
    avatarUrl.value = avatar;
    setDirty();
  }

  void setClass(CharacterClass cls) {
    characterClass.value = cls;
    // TODO remove dupes + use item amount
    setStartingGear(
        cls.gearChoices.fold([], (all, cur) => [...all, ...cur.preselectedGearSelections]));
    addStartingMoves();
    setDirty();
  }

  void setRollStats(RollStats stats) {
    rollStats.value = stats;
    setDirty();
  }

  void setMovesSpells(List<Move> moves, List<Spell> spells) {
    this.moves.clear();
    this.spells.clear();
    this.moves.addAll(moves);
    this.spells.addAll(spells);
  }

  void setDirty() {
    dirty.value = true;
  }

  void setStartingGear(List<GearSelection> selections) {
    startingGear.clear();
    startingGear.addAll(selections);
  }

  void addStartingMoves() {
    moves.clear();
    moves.addAll(
      [...repo.builtIn.moves.values, ...repo.my.moves.values]
          .where((m) => (m.classKeys.contains(characterClass.value!.key) &&
                  m.category == MoveCategory.starting)
              //  || m.category == MoveCategory.basic,
              )
          .map(
            (move) => Move.fromDwMove(move, favorited: move.category != MoveCategory.basic),
          )
          .toList(),
    );
  }

  Character getAsCharacter() => Character.empty().copyWith(
        displayName: name.value,
        avatarUrl: avatarUrl.value,
        characterClass: characterClass.value,
        rollStats: rollStats.value,
        moves: moves,
        spells: spells,
        items: items,
        coins: coins,
      );
}
