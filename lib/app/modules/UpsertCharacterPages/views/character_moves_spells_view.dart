import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_moves_view.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_moves_spells_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CharacterMovesSpellsView extends GetView<CharacterMovesSpellsController> {
  final void Function(bool valid, CharMovesSpells? movesSpells) onValidate;

  const CharacterMovesSpellsView({
    Key? key,
    required this.onValidate,
  }) : super(key: key);

  void updateControllers() {
    onValidate(true, controller.movesSpells);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(
            () => ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              children: controller.moves
                  .map((move) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: MoveCard(
                          move: move,
                          showDice: false,
                        ),
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 48,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Get.to(
                        () => AddMovesView(
                          onAdd: (moves) =>
                              withUpdateController(() => controller.moves.addAll(moves)),
                        ),
                      ),
                      label: Text(S.current.addMovesExisting),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: withUpdateController(_debugAddMoves), // TODO CHANGE!
                      label: Text(S.current.addMovesCustom),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              children: controller.spells
                  .map((spell) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SpellCard(
                          spell: spell,
                          showDice: false,
                        ),
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 48,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: withUpdateController(_debugAddSpells), // TODO CHANGE!
                      label: Text(S.current.addSpellsExisting),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: withUpdateController(_debugAddSpells), // TODO CHANGE!
                      label: Text(S.current.addSpellsCustom),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void Function() withUpdateController(void Function() cb) {
    return () {
      cb();
      updateControllers();
    };
  }

  _debugAddMoves() {
    controller.moves.addAll([
      Move(
        category: MoveCategory.basic,
        name: 'Move 1',
        description: 'Move Description 1',
        explanation: 'Move Explanation 1',
        dice: [dw.Dice.d6 * 2],
        classKeys: [],
        key: 'added_move_1',
        meta: Meta.version(1),
        tags: [],
        favorited: true,
      ),
      Move(
        category: MoveCategory.advanced1,
        name: 'Move 2',
        description: 'Move Description 2',
        explanation: 'Move Explanation 2',
        dice: [dw.Dice.d6 * 2],
        classKeys: [],
        key: 'added_move_2',
        meta: Meta.version(1),
        tags: [],
        favorited: true,
      ),
    ]);
  }

  _debugAddSpells() {
    controller.spells.addAll([
      Spell(
        name: 'Spell 1',
        description: 'Spell Description 1',
        explanation: 'Spell Explanation 1',
        dice: [dw.Dice.d6 * 2],
        classKeys: [],
        key: 'added_spell_1',
        meta: Meta.version(1),
        tags: [],
        prepared: true,
      ),
      Spell(
        name: 'Spell 2',
        description: 'Spell Description 2',
        explanation: 'Spell Explanation 2',
        dice: [dw.Dice.d6 * 2],
        classKeys: [],
        key: 'added_spell_2',
        meta: Meta.version(1),
        tags: [],
        prepared: true,
      ),
    ]);
  }
}
