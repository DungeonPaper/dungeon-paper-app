import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/select_moves_spells_controller.dart';

class SelectMovesSpellsView extends GetView<SelectMovesSpellsController> {
  const SelectMovesSpellsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var titleStyle = Theme.of(context).textTheme.titleLarge;
    return ConfirmExitView(
      dirty: controller.dirty.value,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              tr.generic.selectEntity(tr.createCharacter.movesSpells.title)),
          centerTitle: true,
        ),
        floatingActionButton: AdvancedFloatingActionButton.extended(
          onPressed: _save,
          label: Text(tr.generic.save),
          icon: const Icon(Icons.save),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // MOVES TITLE
              Obx(() => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                        tr.entityCountNum(
                          tn(Move),
                          controller.moves.length,
                        ),
                        style: titleStyle),
                  )),
              // MOVES CARDS
              Obx(
                () => ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  physics: const NeverScrollableScrollPhysics(),
                  children: controller.sortedMoves
                      .map((move) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: MoveCard(
                              move: move,
                              showDice: false,
                              showStar: false,
                              actions: [
                                EntityEditMenu(
                                  onEdit: () => ModelPages.openMovePage(
                                    abilityScores:
                                        controller.abilityScores.value,
                                    move: move,
                                    onSave: (move) => controller.moves.value =
                                        updateByKey(controller.moves, [move]),
                                  ),
                                  onDelete: () => controller.moves.value =
                                      removeByKey(controller.moves, [move]),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              // ADD MOVES
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    style: ButtonThemes.primaryOutlined(context),
                    onPressed: () => ModelPages.openMovesList(
                      character: Character.empty().copyWith(
                        characterClass: controller.characterClass.value,
                      ),
                      preSelections: controller.moves,
                      category: MoveCategory.advanced1,
                      onSelected: (moves) {
                        controller.dirty.value = true;
                        controller.moves.value = addByKey(
                          controller.moves,
                          moves.map((m) => m.copyWithInherited(favorite: true)),
                        );
                      },
                    ),
                    label:
                        Text(tr.generic.addEntity(tr.entityPlural(tn(Move)))),
                    icon: const Icon(Icons.add),
                  ),
                ),
              ),
              // SPELLS TITLE
              Obx(() => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                            .copyWith(top: 24),
                    child: Text(
                        tr.entityCount(
                          tn(Spell),
                          controller.spells.length,
                        ),
                        style: titleStyle),
                  )),
              // SPELL CARDS
              Obx(
                () => ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  physics: const NeverScrollableScrollPhysics(),
                  children: controller.spells
                      .map((spell) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: SpellCard(
                              spell: spell,
                              showDice: false,
                              showStar: false,
                              actions: [
                                ElevatedButton.icon(
                                  style: ButtonThemes.primaryElevated(context),
                                  onPressed: () {
                                    controller.spells.value =
                                        removeByKey(controller.spells, [spell]);
                                  },
                                  label: Text(tr.generic.remove),
                                  icon: const Icon(Icons.remove),
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              // ADD SPELLS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    style: ButtonThemes.primaryOutlined(context),
                    onPressed: () => ModelPages.openSpellsList(
                      character: Character.empty().copyWith(
                        characterClass: controller.characterClass.value,
                      ),
                      list: controller.spells,
                      onSelected: (spells) {
                        controller.dirty.value = true;
                        controller.spells.value = addByKey(
                          controller.spells,
                          spells
                              .map((m) => m.copyWithInherited(prepared: true)),
                        );
                      },
                    ),
                    label:
                        Text(tr.generic.addEntity(tr.entityPlural(tn(Spell)))),
                    icon: const Icon(Icons.add),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  _save() {
    controller.onChanged(controller.moves, controller.spells);
    Get.back();
  }
}
