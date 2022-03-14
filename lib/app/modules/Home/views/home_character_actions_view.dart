import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/bindings/add_repository_items_binding.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_items_view.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_moves_view.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/filters/move_filters.dart';
import 'package:dungeon_paper/app/widgets/atoms/expansion_row.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeCharacterActionsView extends GetView<CharacterService> {
  const HomeCharacterActionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.current == null) {
        return Container();
      }
      return ListView(
        children: [
          ExpansionRow(
            initiallyExpanded: true,
            title: Text(S.current.moves),
            trailing: [
              TextButton.icon(
                onPressed: () => Get.to(
                  () => AddMovesView(
                    onAdd: (moves) => controller.updateCharacter(
                      controller.current!.copyWith(
                        moves: addByKey(controller.current!.moves, moves),
                      ),
                    ),
                  ),
                  binding: AddRepositoryItemsBinding(),
                  arguments: MoveFilters(classKey: controller.current!.characterClass.key),
                ),
                label: Text(S.current.addMoves),
                icon: const Icon(Icons.add),
              )
            ],
            children: (controller.current?.moves ?? [])
                .map(
                  (move) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: MoveCard(
                      move: move,
                      onSave: (_move) => controller.updateCharacter(
                        CharacterUtils.updateMoves(controller.current!, [_move]),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          ExpansionRow(
            initiallyExpanded: true,
            title: Text(S.current.spells),
            trailing: [
              TextButton.icon(
                onPressed: () => Get.to(
                  () => AddMovesView(
                    onAdd: (moves) => controller.updateCharacter(
                      controller.current!.copyWith(
                        moves: addByKey(controller.current!.moves, moves),
                      ),
                    ),
                  ),
                  binding: AddRepositoryItemsBinding(),
                ),
                label: Text(S.current.addSpells),
                icon: const Icon(Icons.add),
              )
            ],
            children: (controller.current?.spells ?? [])
                .map(
                  (spell) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SpellCard(
                      spell: spell,
                      onSave: (_spell) => controller.updateCharacter(
                        CharacterUtils.updateSpells(controller.current!, [_spell]),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          ExpansionRow(
            initiallyExpanded: true,
            title: Text(S.current.items),
            trailing: [
              TextButton.icon(
                onPressed: () => Get.to(
                  () => AddItemsView(
                    onAdd: (items) => controller.updateCharacter(
                      controller.current!.copyWith(
                        items: addByKey(controller.current!.items, items),
                      ),
                    ),
                  ),
                  binding: AddRepositoryItemsBinding(),
                ),
                label: Text(S.current.addItems),
                icon: const Icon(Icons.add),
              )
            ],
            children: (controller.current?.items ?? [])
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ItemCard(
                      item: item,
                      onSave: (_item) => controller.updateCharacter(
                        CharacterUtils.updateItems(controller.current!, [_item]),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      );
    });
  }
}
