import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/app/modules/Home/views/expanded_card_dialog_view.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card_mini.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/note_card.dart';
import 'package:dungeon_paper/app/widgets/cards/note_card_mini.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card_mini.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card_mini.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCharacterDynamicCards extends GetView<CharacterService> {
  const HomeCharacterDynamicCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const cardSize = Size(210, 153);

    return Obx(() {
      final moves = (controller.current?.moves ?? <Move>[]).where((m) => m.favorited);
      final spells = (controller.current?.spells ?? <Spell>[]).where((m) => m.prepared);
      final items = (controller.current?.items ?? <Item>[]).where((m) => m.equipped);
      final notes = (controller.current?.notes ?? <Note>[]).where((n) => n.favorited);

      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (moves.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(S.current.dynamicCategoriesMoves),
              ),
            _HorizontalCardListView<Move>(
              cardSize: cardSize,
              items: moves,
              cardBuilder: (move, _, onTap) => MoveCardMini(
                move: move,
                onTap: onTap,
                onSave: (_move) => controller.updateCharacter(
                  CharacterUtils.updateMoves(controller.current!, [_move]),
                ),
              ),
              expandedCardBuilder: (move, _) => MoveCard(
                initiallyExpanded: true,
                move: move,
                actions: [
                  EntityEditMenu(
                    onEdit: () => controller.updateCharacter(
                      CharacterUtils.updateMoves(controller.current!, [move]),
                    ),
                    onDelete: () => controller.updateCharacter(
                      CharacterUtils.removeMoves(controller.current!, [move]),
                    ),
                  ),
                ],
                onSave: (_move) => controller.updateCharacter(
                  CharacterUtils.updateMoves(controller.current!, [_move]),
                ),
              ),
            ),
            if (spells.isNotEmpty) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(S.current.dynamicCategoriesSpells),
              ),
            ],
            _HorizontalCardListView<Spell>(
              cardSize: cardSize,
              items: spells,
              cardBuilder: (spell, _, onTap) => SpellCardMini(
                spell: spell,
                onSave: (_spell) => controller.updateCharacter(
                  CharacterUtils.updateSpells(controller.current!, [_spell]),
                ),
                onTap: onTap,
              ),
              expandedCardBuilder: (spell, _) => SpellCard(
                initiallyExpanded: true,
                spell: spell,
                actions: [
                  EntityEditMenu(
                    onEdit: () => controller.updateCharacter(
                      CharacterUtils.updateSpells(controller.current!, [spell]),
                    ),
                    onDelete: () => controller.updateCharacter(
                      CharacterUtils.removeSpells(controller.current!, [spell]),
                    ),
                  ),
                ],
                onSave: (_spell) => controller.updateCharacter(
                  CharacterUtils.updateSpells(controller.current!, [_spell]),
                ),
              ),
            ),
            if (items.isNotEmpty) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(S.current.dynamicCategoriesItems),
              ),
            ],
            _HorizontalCardListView<Item>(
              cardSize: cardSize,
              items: items,
              cardBuilder: (item, _, onTap) => ItemCardMini(
                item: item,
                onTap: onTap,
                onSave: (_item) => controller.updateCharacter(
                  CharacterUtils.updateItems(controller.current!, [_item]),
                ),
              ),
              expandedCardBuilder: (item, _) => ItemCard(
                initiallyExpanded: true,
                item: item,
                actions: [
                  EntityEditMenu(
                    onEdit: () => controller.updateCharacter(
                      CharacterUtils.updateItems(controller.current!, [item]),
                    ),
                    onDelete: () => controller.updateCharacter(
                      CharacterUtils.removeItems(controller.current!, [item]),
                    ),
                  ),
                ],
                onSave: (_item) => controller.updateCharacter(
                  CharacterUtils.updateItems(controller.current!, [_item]),
                ),
              ),
            ),
            if (notes.isNotEmpty) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(S.current.dynamicCategoriesNotes),
              ),
            ],
            _HorizontalCardListView<Note>(
              cardSize: cardSize,
              items: notes,
              cardBuilder: (note, _, onTap) => NoteCardMini(
                note: note,
                onTap: onTap,
                onSave: (_note) => controller.updateCharacter(
                  CharacterUtils.updateNotes(controller.current!, [_note]),
                ),
              ),
              expandedCardBuilder: (note, _) => NoteCard(
                initiallyExpanded: true,
                note: note,
                actions: [
                  EntityEditMenu(
                    onEdit: () => controller.updateCharacter(
                      CharacterUtils.updateNotes(controller.current!, [note]),
                    ),
                    onDelete: () => controller.updateCharacter(
                      CharacterUtils.removeNotes(controller.current!, [note]),
                    ),
                  ),
                ],
                onSave: (_note) => controller.updateCharacter(
                  CharacterUtils.updateNotes(controller.current!, [_note]),
                ),
              ),
            ),
          ]);
    });
  }
}

class _HorizontalCardListView<T> extends StatelessWidget {
  const _HorizontalCardListView({
    Key? key,
    required this.cardSize,
    required this.items,
    required this.cardBuilder,
    required this.expandedCardBuilder,
  }) : super(key: key);

  final Size cardSize;
  final Widget Function(T item, int index, void Function() onTap) cardBuilder;
  final Widget Function(T item, int index) expandedCardBuilder;
  final Iterable<T> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Container();
    }
    return SizedBox(
      height: cardSize.height,
      width: double.infinity,
      // width: 200,
      child: ListView(
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // itemExtent: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          for (final item in Enumerated.listFrom(items))
            Padding(
              padding: EdgeInsets.only(right: item.index == items.length - 1 ? 0 : 8),
              child: SizedBox(
                width: cardSize.width,
                child: Hero(
                  tag: getKeyFor(item.value),
                  child: cardBuilder(
                    item.value,
                    item.index,
                    () => Get.to(
                      () => ExpandedCardDialogView(
                        heroTag: getKeyFor(item.value),
                        builder: () => expandedCardBuilder(item.value, item.index),
                      ),
                      opaque: false,
                      transition: Transition.fadeIn,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String getKeyFor(T item) => [item.runtimeType, keyFor(item)].join('-');
}
