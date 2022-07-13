import 'package:dungeon_paper/app/data/models/character_settings.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/library_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card_mini.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card_mini.dart';
import 'package:dungeon_paper/app/widgets/cards/note_card.dart';
import 'package:dungeon_paper/app/widgets/cards/note_card_mini.dart';
import 'package:dungeon_paper/app/widgets/cards/race_card.dart';
import 'package:dungeon_paper/app/widgets/cards/race_card_mini.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card_mini.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../expanded_card_dialog_view.dart';
import 'horizontal_list_card_view.dart';

class HomeCharacterDynamicCards extends GetView<CharacterService> with LibraryServiceMixin {
  const HomeCharacterDynamicCards({Key? key}) : super(key: key);

  List<Move> get moves =>
      (controller.maybeCurrent?.moves ?? <Move>[]).where((m) => m.favorited).toList();
  List<Spell> get spells =>
      (controller.maybeCurrent?.spells ?? <Spell>[]).where((m) => m.prepared).toList();
  List<Item> get items =>
      (controller.maybeCurrent?.items ?? <Item>[]).where((m) => m.equipped).toList();
  List<Note> get notes =>
      (controller.maybeCurrent?.notes ?? <Note>[]).where((n) => n.favorited).toList();

  @override
  Widget build(BuildContext context) {
    const cardSize = Size(210, 151);
    final maxContentHeight = MediaQuery.of(context).size.height - 250;
    return Obx(
      () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    CharacterUtils.updateNotes(controller.current, [_note]),
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
                      onEdit: () => ModelPages.openNotePage(
                        note: notes[index],
                        onSave: (note) => controller.updateCharacter(
                          CharacterUtils.updateNotes(controller.current, [note]),
                        ),
                      ),
                      onDelete: _delete(
                        context,
                        note,
                        note.title,
                        () => controller.updateCharacter(
                          CharacterUtils.removeNotes(controller.current, [note]),
                        ),
                      ),
                    ),
                  ],
                  onSave: (_note) => controller.updateCharacter(
                    CharacterUtils.updateNotes(controller.current, [_note]),
                  ),
                ),
              ),
            ),
            //
            // MOVES
            //
            if (moves.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(S.current.dynamicCategoriesMoves),
              ),
            Builder(builder: (context) {
              final raceCardMini = controller.current.race.favorited
                  ? RaceCardMini(
                      race: controller.current.race,
                      onTap: () => Get.dialog(
                        ExpandedCardDialogView<Race>(
                          // heroTag: getKeyFor(item.value),
                          heroTag: null,
                          builder: (context) => RaceCard(
                            maxContentHeight: maxContentHeight,
                            expandable: false,
                            initiallyExpanded: true,
                            race: controller.current.race,
                            actions: [
                              EntityEditMenu(
                                onEdit: () => ModelPages.openRacePage(
                                  abilityScores: controller.current.abilityScores,
                                  race: controller.current.race,
                                  onSave: (_race) => controller.updateCharacter(
                                    controller.current.copyWith(race: _race),
                                  ),
                                ),
                                onDelete: null,
                              ),
                            ],
                            onSave: (_race) => controller.updateCharacter(
                              controller.current.copyWith(race: _race),
                            ),
                          ),
                        ),
                      ),
                      onSave: (_race) => controller.updateCharacter(
                        controller.current.copyWith(race: _race),
                      ),
                    )
                  : null;
              return HorizontalCardListView<Move>(
                cardSize: cardSize,
                items: moves,
                cardBuilder: (context, move, index, onTap) => Obx(
                  () => MoveCardMini(
                    move: moves[index],
                    onTap: onTap,
                    onSave: (_move) => controller.updateCharacter(
                      CharacterUtils.updateMoves(controller.current, [_move]),
                    ),
                    abilityScores: controller.current.abilityScores,
                  ),
                ),
                expandedCardBuilder: (context, move, index) => Obx(
                  () => MoveCard(
                    maxContentHeight: maxContentHeight,
                    expandable: false,
                    initiallyExpanded: true,
                    move: moves[index],
                    abilityScores: controller.current.abilityScores,
                    actions: [
                      EntityEditMenu(
                        onEdit: () => ModelPages.openMovePage(
                          abilityScores: controller.current.abilityScores,
                          move: moves[index],
                          onSave: (move) => library.upsertToCharacter([move],
                              forkBehavior: ForkBehavior.increaseVersion),
                        ),
                        onDelete: _delete(
                          context,
                          move,
                          move.name,
                          () => controller.updateCharacter(
                            CharacterUtils.removeMoves(controller.current, [move]),
                          ),
                        ),
                      ),
                    ],
                    onSave: (_move) => controller.updateCharacter(
                      CharacterUtils.updateMoves(controller.current, [_move]),
                    ),
                  ),
                ),
                leading: raceCardMini != null &&
                        controller.current.settings.racePosition == RacePosition.start
                    ? [raceCardMini]
                    : [],
                trailing: raceCardMini != null &&
                        controller.current.settings.racePosition == RacePosition.end
                    ? [raceCardMini]
                    : [],
              );
            }),
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
                    CharacterUtils.updateSpells(controller.current, [_spell]),
                  ),
                  abilityScores: controller.current.abilityScores,
                ),
              ),
              expandedCardBuilder: (context, spell, index) => Obx(
                () => SpellCard(
                  maxContentHeight: maxContentHeight,
                  expandable: false,
                  initiallyExpanded: true,
                  spell: spells[index],
                  abilityScores: controller.current.abilityScores,
                  actions: [
                    EntityEditMenu(
                      onEdit: () => ModelPages.openSpellPage(
                        abilityScores: controller.current.abilityScores,
                        classKeys: spells[index].classKeys,
                        spell: spells[index],
                        onSave: (spell) => controller.updateCharacter(
                          CharacterUtils.updateSpells(controller.current, [spell]),
                        ),
                      ),
                      onDelete: _delete(
                        context,
                        spell,
                        spell.name,
                        () => controller.updateCharacter(
                          CharacterUtils.removeSpells(controller.current, [spell]),
                        ),
                      ),
                    ),
                  ],
                  onSave: (_spell) => controller.updateCharacter(
                    CharacterUtils.updateSpells(controller.current, [_spell]),
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
                    CharacterUtils.updateItems(controller.current, [_item]),
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
                      onEdit: () => ModelPages.openItemPage(
                        item: items[index],
                        onSave: (item) => controller.updateCharacter(
                          CharacterUtils.updateItems(controller.current, [item]),
                        ),
                      ),
                      onDelete: _delete(
                        context,
                        item,
                        item.name,
                        () => controller.updateCharacter(
                          CharacterUtils.removeItems(controller.current, [item]),
                        ),
                      ),
                    ),
                  ],
                  onSave: (_item) => controller.updateCharacter(
                    CharacterUtils.updateItems(controller.current, [_item]),
                  ),
                ),
              ),
            ),
          ]),
    );
  }

  void Function() _delete<T>(
      BuildContext context, T item, String itemName, void Function() onRemove) {
    return () => awaitDeleteConfirmation<T>(
          context,
          itemName,
          () {
            onRemove();
            Get.back();
          },
        );
  }
}
