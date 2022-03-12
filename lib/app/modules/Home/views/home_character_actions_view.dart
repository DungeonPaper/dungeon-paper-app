import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
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
