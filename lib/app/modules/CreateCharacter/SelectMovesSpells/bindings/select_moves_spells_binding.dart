import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:get/get.dart';

import '../controllers/select_moves_spells_controller.dart';

class SelectMovesSpellsBinding extends Bindings {
  final List<Move> moves;
  final List<Spell> spells;
  final RollStats rollStats;
  final CharacterClass characterClass;

  SelectMovesSpellsBinding({
    required this.moves,
    required this.spells,
    required this.rollStats,
    required this.characterClass,
  });

  @override
  void dependencies() {
    Get.put<SelectMovesSpellsController>(
      SelectMovesSpellsController(
        moves: moves,
        spells: spells,
        rollStats: rollStats,
        characterClass: characterClass,
      ),
    );
  }
}
