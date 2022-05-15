import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:get/get.dart';

import '../controllers/select_moves_spells_controller.dart';

class SelectMovesSpellsBinding extends Bindings {
  final List<Move> moves;
  final List<Spell> spells;
  final AbilityScores abilityScores;
  final CharacterClass characterClass;

  SelectMovesSpellsBinding({
    required this.moves,
    required this.spells,
    required this.abilityScores,
    required this.characterClass,
  });

  @override
  void dependencies() {
    Get.put<SelectMovesSpellsController>(
      SelectMovesSpellsController(
        moves: moves,
        spells: spells,
        abilityScores: abilityScores,
        characterClass: characterClass,
      ),
    );
  }
}
