import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/bindings/add_repository_items_binding.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/bindings/repository_item_form_binding.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_items_view.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_moves_view.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_spells_view.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/filters/item_filters.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/filters/move_filters.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/filters/spell_filters.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/expansion_row.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:dungeon_paper/app/widgets/forms/repository_item_form.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeCharacterActionsView extends GetView<CharacterService> {
  const HomeCharacterActionsView({Key? key}) : super(key: key);

  Character get char => controller.current!;

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: PageStorageBucket(),
      child: Obx(() {
        if (controller.current == null) {
          return Container();
        }
        return ListView(
          children: [
            // MOVES LIST
            ExpansionRow(
              initiallyExpanded: true,
              title: Text(S.current.moves),
              trailing: [
                TextButton.icon(
                  onPressed: () => Get.to(
                    () => AddMovesView(
                      onAdd: (moves) => controller.updateCharacter(
                        char.copyWith(
                          moves: addByKey(char.moves, moves),
                        ),
                      ),
                      rollStats: char.rollStats,
                      selections: char.moves,
                      classKeys: [char.characterClass.key],
                    ),
                    binding: AddRepositoryItemsBinding(),
                    arguments: {
                      FiltersGroup.playbook: MoveFilters(classKey: char.characterClass.key),
                      FiltersGroup.my: MoveFilters(classKey: char.characterClass.key),
                    },
                  ),
                  label: Text(S.current.addGeneric(S.current.entityPlural(Move))),
                  icon: const Icon(Icons.add),
                )
              ],
              children: char.moves
                  .map(
                    (move) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: MoveCard(
                        move: move,
                        actions: [
                          EntityEditMenu(
                            onDelete: confirmDeleteDlg(context, move, move.name),
                            onEdit: () => Get.to(
                              () => RepositoryItemForm<Move>(
                                onSave: (_move) => controller.updateCharacter(
                                  char.copyWith(
                                    moves: updateByKey(char.moves, [_move]),
                                  ),
                                ),
                                extraData: {
                                  'rollStats': controller.current!.rollStats,
                                  'classKeys': move.classKeys,
                                },
                                type: ItemFormType.create,
                              ),
                              binding: RepositoryItemFormBinding(
                                item: move,
                                extraData: {
                                  'rollStats': controller.current!.rollStats,
                                  'classKeys': move.classKeys,
                                },
                              ),
                            ),
                          ),
                        ],
                        onSave: (_move) => controller.updateCharacter(
                          CharacterUtils.updateMoves(char, [_move]),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),

            // SPELLS LIST
            ExpansionRow(
              initiallyExpanded: true,
              title: Text(S.current.spells),
              trailing: [
                TextButton.icon(
                  onPressed: () => Get.to(
                    () => AddSpellsView(
                      onAdd: (spells) => controller.updateCharacter(
                        char.copyWith(
                          spells: addByKey(char.spells, spells),
                        ),
                      ),
                      classKeys: [char.characterClass.key],
                      rollStats: char.rollStats,
                      selections: char.spells,
                    ),
                    binding: AddRepositoryItemsBinding(),
                    arguments: {
                      FiltersGroup.playbook: SpellFilters(),
                      FiltersGroup.my: SpellFilters()
                    },
                  ),
                  label: Text(S.current.addGeneric(S.current.entityPlural(Spell))),
                  icon: const Icon(Icons.add),
                )
              ],
              children: char.spells
                  .map(
                    (spell) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SpellCard(
                        spell: spell,
                        actions: [
                          EntityEditMenu(
                            onDelete: confirmDeleteDlg(context, spell, spell.name),
                            onEdit: () => Get.to(
                              () => RepositoryItemForm<Spell>(
                                onSave: (_spell) => controller.updateCharacter(
                                  char.copyWith(
                                    spells: updateByKey(char.spells, [_spell]),
                                  ),
                                ),
                                extraData: {
                                  'rollStats': controller.current!.rollStats,
                                  'classKeys': spell.classKeys,
                                },
                                type: ItemFormType.create,
                              ),
                              binding: RepositoryItemFormBinding(
                                item: spell,
                                extraData: {
                                  'rollStats': controller.current!.rollStats,
                                  'classKeys': spell.classKeys,
                                },
                              ),
                            ),
                          ),
                        ],
                        onSave: (_spell) => controller.updateCharacter(
                          CharacterUtils.updateSpells(char, [_spell]),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),

            // ITEMS LIST
            ExpansionRow(
              initiallyExpanded: true,
              title: Text(S.current.items),
              trailing: [
                TextButton.icon(
                  onPressed: () => Get.to(
                    () => AddItemsView(
                      onAdd: (items) => controller.updateCharacter(
                        char.copyWith(
                          items: addByKey(char.items, items),
                        ),
                      ),
                      selections: char.items,
                    ),
                    binding: AddRepositoryItemsBinding(),
                    arguments: {
                      FiltersGroup.playbook: ItemFilters(),
                      FiltersGroup.my: ItemFilters()
                    },
                  ),
                  label: Text(S.current.addGeneric(S.current.entityPlural(Item))),
                  icon: const Icon(Icons.add),
                )
              ],
              children: char.items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ItemCard(
                        item: item,
                        actions: [
                          EntityEditMenu(
                            onDelete: confirmDeleteDlg(context, item, item.name),
                            onEdit: () => Get.to(
                              () => RepositoryItemForm<Item>(
                                onSave: (_item) => controller.updateCharacter(
                                  char.copyWith(
                                    items: updateByKey(char.items, [_item]),
                                  ),
                                ),
                                extraData: {
                                  'rollStats': controller.current!.rollStats,
                                },
                                type: ItemFormType.create,
                              ),
                              binding: RepositoryItemFormBinding(
                                item: item,
                                extraData: {
                                  'rollStats': controller.current!.rollStats,
                                },
                              ),
                            ),
                          ),
                        ],
                        onSave: (_item) => controller.updateCharacter(
                          CharacterUtils.updateItems(char, [_item]),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      }),
    );
  }

  void Function() confirmDeleteDlg<T>(BuildContext context, T object, String name) {
    return () async {
      final result = await confirmDelete(context, name);

      if (result == true) {
        switch (T) {
          case Move:
            controller.updateCharacter(
              char.copyWith(moves: removeByKey(char.moves, [object as Move])),
            );
            break;
          case Spell:
            controller.updateCharacter(
              char.copyWith(spells: removeByKey(char.spells, [object as Spell])),
            );
            break;
          case Item:
            controller.updateCharacter(
              char.copyWith(items: removeByKey(char.items, [object as Item])),
            );
            break;
          default:
            throw TypeError();
        }
      }
    };
  }
}
