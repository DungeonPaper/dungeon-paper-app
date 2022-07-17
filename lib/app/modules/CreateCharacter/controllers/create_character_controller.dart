import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/models/bio.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/character_stats.dart';
import 'package:dungeon_paper/app/data/models/gear_choice.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:get/get.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class CreateCharacterController extends GetxController {
  final name = ''.obs;
  final avatarUrl = ''.obs;
  final characterClass = Rx<CharacterClass?>(null);
  final abilityScores =
      AbilityScores.dungeonWorld(dex: 10, str: 10, wis: 10, con: 10, intl: 10, cha: 10).obs;
  final startingGear = <GearSelection>[].obs;
  final moves = <Move>[].obs;
  final spells = <Spell>[].obs;
  final alignment = Rx<AlignmentValue?>(null);
  final race = Rx<Race?>(null);

  final repo = Get.find<RepositoryService>();
  final dirty = false.obs;

  User get user => Get.find<UserService>().current;

  bool get isValid => [
        name.isNotEmpty,
        characterClass.value != null,
        alignment.value != null,
        race.value != null,
      ].every((element) => element == true);

  List<Item> get items => GearChoice.selectionToItems(startingGear, equipped: true);

  double get coins => GearChoice.selectionToCoins(startingGear);

  void setBasicInfo(String name, String avatar) {
    this.name.value = name;
    avatarUrl.value = avatar;
    setDirty();
  }

  void setClass(CharacterClass cls) {
    characterClass.value = cls;
    setStartingGear(
      cls.gearChoices.fold([], (all, cur) => [...all, ...cur.preselectedGearSelections]),
    );
    addStartingMoves();
    setDirty();
  }

  void setAbilityScores(AbilityScores stats) {
    abilityScores.value = stats;
    setDirty();
  }

  void setAlignment(AlignmentValues alignments, dw.AlignmentType? selected) {
    if (selected == null) {
      return;
    }
    alignment.value = AlignmentValue.empty(type: selected).copyWith(
      description: alignments.byType(selected),
    );
    setDirty();
  }

  void setMovesSpells(List<Move> moves, List<Spell> spells) {
    this.moves.clear();
    this.spells.clear();
    this.moves.addAll(moves.map((e) => e.copyWithInherited(favorite: true)));
    this.spells.addAll(spells.map((e) => e.copyWithInherited(prepared: true)));
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
              m.category == MoveCategory.starting))
          .map(
            // favorite: move.category != MoveCategory.basic
            (move) => Move.fromDwMove(move, favorite: true),
          )
          .toList(),
    );
  }

  Character getAsCharacter() => Character.empty().copyWith(
        displayName: name.value,
        avatarUrl: avatarUrl.value,
        characterClass: characterClass.value,
        abilityScores: abilityScores.value,
        moves: moves,
        spells: spells,
        items: items,
        coins: coins,
        race: race.value,
        stats: CharacterStats(
          level: 1,
          currentHp: characterClass.value!.hp + abilityScores.value.conMod!,
          currentXp: 0,
        ),
        sessionMarks: [
          ...(characterClass.value?.bonds
                  .map((bond) => SessionMark.bond(description: bond, completed: false, key: uuid()))
                  .toList() ??
              []),
          ...Character.defaultEndOfSessionMarks,
        ],
        bio: Bio(
          looks: '',
          description: '',
          alignment: alignment.value ?? AlignmentValue.empty(),
        ),
      );
}
