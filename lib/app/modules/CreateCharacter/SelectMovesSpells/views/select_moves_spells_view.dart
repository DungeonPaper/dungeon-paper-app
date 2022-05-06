import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/bindings/add_repository_items_binding.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_moves_view.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_spells_view.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/filters/move_filters.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/filters/spell_filters.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/select_moves_spells_controller.dart';

class SelectMovesSpellsView extends GetView<SelectMovesSpellsController> {
  const SelectMovesSpellsView({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final void Function(List<Move> moves, List<Spell> spells) onChanged;

  @override
  Widget build(BuildContext context) {
    var titleStyle = Theme.of(context).textTheme.headline6;
    return ConfirmExitView(
      dirty: controller.dirty.value,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Moves & Spells'),
          centerTitle: true,
        ),
        floatingActionButton: AdvancedFloatingActionButton.extended(
          onPressed: _save,
          label: Text(S.current.save),
          icon: const Icon(Icons.save),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // MOVES TITLE
              Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child:
                        Text(S.current.movesWithCount(controller.moves.length), style: titleStyle),
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
                                  onEdit: CharacterUtils.openMovePage(
                                    rollStats: controller.rollStats.value,
                                    classKeys: move.classKeys,
                                    move: move,
                                    onSave: (_move) => controller.moves.value =
                                        updateByKey(controller.moves, [_move]),
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
                    onPressed: () => Get.to(
                      () => AddMovesView(
                        onAdd: (moves) {
                          controller.dirty.value = true;
                          controller.moves.value = addByKey(
                            controller.moves,
                            moves.map((m) => m.copyWithInherited(favorited: true)),
                          );
                        },
                        rollStats: controller.rollStats.value,
                        classKeys: [controller.characterClass.value.key],
                        selections: controller.moves,
                      ),
                      binding: AddRepositoryItemsBinding(),
                      arguments: {
                        FiltersGroup.playbook: MoveFilters(
                          classKey: controller.characterClass.value.key,
                        ),
                        FiltersGroup.my: MoveFilters(
                          classKey: controller.characterClass.value.key,
                        )
                      },
                    ),
                    label: Text(S.current.addGeneric(S.current.entityPlural(Move))),
                    icon: const Icon(Icons.add),
                  ),
                ),
              ),
              // SPELLS TITLE
              Obx(() => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8).copyWith(top: 24),
                    child: Text(S.current.spellsWithCount(controller.spells.length),
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
                                  label: Text(S.current.remove),
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
                    onPressed: () => Get.to(
                      () => AddSpellsView(
                        onAdd: (spells) {
                          controller.dirty.value = true;
                          controller.spells.value = addByKey(
                            controller.spells,
                            spells.map((s) => s.copyWithInherited(prepared: true)),
                          );
                        },
                        rollStats: controller.rollStats.value,
                        classKeys: [controller.characterClass.value.key],
                        selections: controller.spells,
                      ),
                      binding: AddRepositoryItemsBinding(),
                      arguments: {
                        FiltersGroup.playbook: SpellFilters(
                          classKey: controller.characterClass.value.key,
                        ),
                        FiltersGroup.my: SpellFilters(
                          classKey: controller.characterClass.value.key,
                        ),
                      },
                    ),
                    label: Text(S.current.addGeneric(S.current.entityPlural(Spell))),
                    icon: const Icon(Icons.add),
                  ),
                ),
              ),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }

  _save() {
    onChanged(controller.moves, controller.spells);
    Get.back();
  }
}
