import 'dart:async';

import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/create_character_page_controller.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';

class CharacterMovesSpellsController extends GetxController {
  final moves = <Move>[].obs;
  final spells = <Spell>[].obs;

  final repo = Get.find<RepositoryService>();
  final ctrl = Get.find<CreateCharacterPageController>();
  late StreamSubscription sub;

  @override
  void onInit() {
    super.onInit();
    addStartingMoves();
    sub = ctrl.charClass.listen((v) => addStartingMoves());
    Future.delayed(const Duration(milliseconds: 200))
        .then((_) => ctrl.setValid(CreateCharStep.movesSpells, true, movesSpells));
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  addStartingMoves() {
    moves.clear();
    moves.addAll(
      [...repo.builtIn.moves.values, ...repo.my.moves.values]
          .where(
            (m) =>
                (m.classKeys.contains(ctrl.charClass.value!.key) &&
                    m.category == MoveCategory.starting) ||
                m.category == MoveCategory.basic,
          )
          .map(
            (move) => Move.fromDwMove(move, favorited: move.category != MoveCategory.basic),
          )
          .toList(),
    );
  }

  Iterable<Move> get sortedMoves => [...moves]..sort((a, b) => a.category == b.category
      ? cleanStr(a.name).compareTo(cleanStr(b.name))
      : a.category == MoveCategory.basic
          ? -1
          : b.category == MoveCategory.basic
              ? 1
              : 0);

  CharMovesSpells get movesSpells => CharMovesSpells(moves: moves, spells: spells);
}

class CharMovesSpells {
  final List<Move> moves;
  final List<Spell> spells;

  CharMovesSpells({
    required this.moves,
    required this.spells,
  });
}
