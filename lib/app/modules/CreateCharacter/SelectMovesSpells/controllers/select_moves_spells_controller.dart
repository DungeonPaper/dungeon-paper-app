import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';

class SelectMovesSpellsController extends GetxController {
  final dirty = false.obs;
  final repo = Get.find<RepositoryService>();

  final moves = <Move>[].obs;
  final spells = <Spell>[].obs;
  late final Rx<AbilityScores> abilityScores;
  late final Rx<CharacterClass> characterClass;
  late final void Function(List<Move> moves, List<Spell> spells) onChanged;

  @override
  void onReady() {
    super.onReady();
    final SelectMovesSpellsArguments args = Get.arguments;
    moves.value = args.moves.toList();
    spells.value = args.spells.toList();
    abilityScores = args.abilityScores.obs;
    characterClass = args.characterClass.obs;
    onChanged = args.onChanged;
  }

  Iterable<Move> get sortedMoves =>
      [...moves]..sort((a, b) => a.category == b.category
          ? cleanStr(a.name).compareTo(cleanStr(b.name))
          : a.category == MoveCategory.basic
              ? -1
              : b.category == MoveCategory.basic
                  ? 1
                  : 0);
}

class SelectMovesSpellsArguments {
  final void Function(List<Move> moves, List<Spell> spells) onChanged;
  final List<Move> moves;
  final List<Spell> spells;
  final AbilityScores abilityScores;
  final CharacterClass characterClass;

  SelectMovesSpellsArguments({
    required this.onChanged,
    required this.moves,
    required this.spells,
    required this.abilityScores,
    required this.characterClass,
  });
}
