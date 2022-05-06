import 'dart:async';

import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';

class SelectMovesSpellsController extends GetxController {
  final RxList<Move> moves;
  final RxList<Spell> spells;
  final dirty = false.obs;
  final Rx<RollStats> rollStats;
  final Rx<CharacterClass> characterClass;

  SelectMovesSpellsController({
    required List<Move> moves,
    required List<Spell> spells,
    required RollStats rollStats,
    required CharacterClass characterClass,
  })  : moves = moves.obs,
        spells = spells.obs,
        rollStats = rollStats.obs,
        characterClass = characterClass.obs;

  final repo = Get.find<RepositoryService>();
  late StreamSubscription sub;

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  Iterable<Move> get sortedMoves => [...moves]..sort((a, b) => a.category == b.category
      ? cleanStr(a.name).compareTo(cleanStr(b.name))
      : a.category == MoveCategory.basic
          ? -1
          : b.category == MoveCategory.basic
              ? 1
              : 0);
}
