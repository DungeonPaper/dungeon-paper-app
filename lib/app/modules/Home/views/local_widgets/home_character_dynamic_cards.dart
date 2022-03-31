import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card_mini.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card_mini.dart';
import 'package:dungeon_paper/app/widgets/cards/note_card.dart';
import 'package:dungeon_paper/app/widgets/cards/note_card_mini.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card_mini.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'horizontal_list_card_view.dart';

class HomeCharacterDynamicCards extends GetView<CharacterService> {
  const HomeCharacterDynamicCards({Key? key}) : super(key: key);

  List<Move> get moves =>
      (controller.current?.moves ?? <Move>[]).where((m) => m.favorited).toList();
  List<Spell> get spells =>
      (controller.current?.spells ?? <Spell>[]).where((m) => m.prepared).toList();
  List<Item> get items => (controller.current?.items ?? <Item>[]).where((m) => m.equipped).toList();
  List<Note> get notes =>
      (controller.current?.notes ?? <Note>[]).where((n) => n.favorited).toList();

  @override
  Widget build(BuildContext context) {
    const cardSize = Size(210, 157);
    final maxContentHeight = MediaQuery.of(context).size.height - 250;
    return Obx(
      () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            // MOVES
            //
            if (moves.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(S.current.dynamicCategoriesMoves),
              ),
            HorizontalCardListView<Move>(
              cardSize: cardSize,
              items: moves,
              cardBuilder: (context, move, index, onTap) => Obx(
                () => MoveCardMini(
                  move: moves[index],
                  onTap: onTap,
                  onSave: (_move) => controller.updateCharacter(
                    CharacterUtils.updateMoves(controller.current!, [_move]),
                  ),
                ),
              ),
              expandedCardBuilder: (context, move, index) => Obx(
                () => MoveCard(
                  maxContentHeight: maxContentHeight,
                  expandable: false,
                  initiallyExpanded: true,
                  move: moves[index],
                  actions: [
                    EntityEditMenu(
                      onEdit: CharacterUtils.openMovePage(
                        rollStats: controller.current!.rollStats,
                        classKeys: moves[index].classKeys,
                        move: moves[index],
                        onSave: (move) => controller.updateCharacter(
                          CharacterUtils.updateMoves(controller.current!, [move]),
                        ),
                      ),
                      onDelete: _delete(
                        context,
                        move,
                        move.name,
                        () => controller.updateCharacter(
                          CharacterUtils.removeMoves(controller.current!, [move]),
                        ),
                      ),
                    ),
                  ],
                  onSave: (_move) => controller.updateCharacter(
                    CharacterUtils.updateMoves(controller.current!, [_move]),
                  ),
                ),
              ),
            ),
            //
            // SPELLS
            //
            if (spells.isNotEmpty) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(S.current.dynamicCategoriesSpells),
              ),
            ],
            HorizontalCardListView<Spell>(
              cardSize: cardSize,
              items: spells,
              cardBuilder: (context, spell, index, onTap) => Obx(
                () => SpellCardMini(
                  spell: spells[index],
                  onTap: onTap,
                  onSave: (_spell) => controller.updateCharacter(
                    CharacterUtils.updateSpells(controller.current!, [_spell]),
                  ),
                ),
              ),
              expandedCardBuilder: (context, spell, index) => Obx(
                () => SpellCard(
                  maxContentHeight: maxContentHeight,
                  expandable: false,
                  initiallyExpanded: true,
                  spell: spells[index],
                  actions: [
                    EntityEditMenu(
                      onEdit: CharacterUtils.openSpellPage(
                        rollStats: controller.current!.rollStats,
                        classKeys: spells[index].classKeys,
                        spell: spells[index],
                        onSave: (spell) => controller.updateCharacter(
                          CharacterUtils.updateSpells(controller.current!, [spell]),
                        ),
                      ),
                      onDelete: _delete(
                        context,
                        spell,
                        spell.name,
                        () => controller.updateCharacter(
                          CharacterUtils.removeSpells(controller.current!, [spell]),
                        ),
                      ),
                    ),
                  ],
                  onSave: (_spell) => controller.updateCharacter(
                    CharacterUtils.updateSpells(controller.current!, [_spell]),
                  ),
                ),
              ),
            ),
            //
            // ITEMS
            //
            if (items.isNotEmpty) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(S.current.dynamicCategoriesItems),
              ),
            ],
            HorizontalCardListView<Item>(
              cardSize: cardSize,
              items: items,
              cardBuilder: (context, item, index, onTap) => Obx(
                () => ItemCardMini(
                  item: items[index],
                  onTap: onTap,
                  onSave: (_item) => controller.updateCharacter(
                    CharacterUtils.updateItems(controller.current!, [_item]),
                  ),
                ),
              ),
              expandedCardBuilder: (context, item, index) => Obx(
                () => ItemCard(
                  maxContentHeight: maxContentHeight,
                  expandable: false,
                  initiallyExpanded: true,
                  item: items[index],
                  actions: [
                    EntityEditMenu(
                      onEdit: CharacterUtils.openItemPage(
                        item: items[index],
                        onSave: (item) => controller.updateCharacter(
                          CharacterUtils.updateItems(controller.current!, [item]),
                        ),
                      ),
                      onDelete: _delete(
                        context,
                        item,
                        item.name,
                        () => controller.updateCharacter(
                          CharacterUtils.removeItems(controller.current!, [item]),
                        ),
                      ),
                    ),
                  ],
                  onSave: (_item) => controller.updateCharacter(
                    CharacterUtils.updateItems(controller.current!, [_item]),
                  ),
                ),
              ),
            ),
            //
            // NOTES
            //
            if (notes.isNotEmpty) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(S.current.dynamicCategoriesNotes),
              ),
            ],
            HorizontalCardListView<Note>(
              cardSize: cardSize,
              items: notes,
              cardBuilder: (context, note, index, onTap) => Obx(
                () => NoteCardMini(
                  note: notes[index],
                  onTap: onTap,
                  onSave: (_note) => controller.updateCharacter(
                    CharacterUtils.updateNotes(controller.current!, [_note]),
                  ),
                ),
              ),
              expandedCardBuilder: (context, note, index) => Obx(
                () => NoteCard(
                  maxContentHeight: maxContentHeight,
                  expandable: false,
                  initiallyExpanded: true,
                  note: notes[index],
                  actions: [
                    EntityEditMenu(
                      onEdit: CharacterUtils.openNotePage(
                        note: notes[index],
                        onSave: (note) => controller.updateCharacter(
                          CharacterUtils.updateNotes(controller.current!, [note]),
                        ),
                      ),
                      onDelete: _delete(
                        context,
                        note,
                        note.title,
                        () => controller.updateCharacter(
                          CharacterUtils.removeNotes(controller.current!, [note]),
                        ),
                      ),
                    ),
                  ],
                  onSave: (_note) => controller.updateCharacter(
                    CharacterUtils.updateNotes(controller.current!, [_note]),
                  ),
                ),
              ),
            ),
          ]),
    );
  }

  void Function() _delete<T>(
      BuildContext context, T item, String itemName, void Function() onRemove) {
    return () => awaitConfirmation(
          confirmDelete<T>(context, itemName),
          () {
            onRemove();
            Get.back();
          },
        );
  }
}
