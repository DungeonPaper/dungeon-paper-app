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
import 'package:dungeon_paper/app/widgets/atoms/checklist_menu_entry.dart';
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
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../expanded_card_dialog_view.dart';
import 'horizontal_list_card_view.dart';

class HomeCharacterDynamicCards extends GetView<CharacterService>
    with LibraryServiceMixin {
  const HomeCharacterDynamicCards({super.key});

  List<Move> get moves => (controller.maybeCurrent?.moves ?? <Move>[])
      .where((m) => m.favorite)
      .toList();
  List<Spell> get spells => (controller.maybeCurrent?.spells ?? <Spell>[])
      .where((m) => m.prepared)
      .toList();
  List<Item> get items => (controller.maybeCurrent?.items ?? <Item>[])
      .where((m) => m.equipped)
      .toList();
  List<Note> get notes => (controller.maybeCurrent?.notes ?? <Note>[])
      .where((n) => n.favorite)
      .toList();

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
                child: Text(tr.home.categories.notes),
              ),
            ],
            HorizontalCardListView<Note>(
              cardSize: cardSize,
              items: notes,
              cardBuilder: (context, note, index, onTap) => Obx(
                () => NoteCardMini(
                  note: notes[index],
                  onTap: onTap,
                  onSave: (note) => controller.updateCharacter(
                    CharacterUtils.updateNotes(controller.current, [note]),
                  ),
                ),
              ),
              expandedCardBuilder: (context, note, index) => Obx(
                () {
                  return notes.isNotEmpty && index < notes.length
                      ? NoteCard(
                          maxContentHeight: maxContentHeight,
                          expandable: false,
                          initiallyExpanded: true,
                          note: notes[index],
                          actions: [
                            EntityEditMenu(
                              onEdit: () => ModelPages.openNotePage(
                                note: notes[index],
                                onSave: (note) => controller.updateCharacter(
                                  CharacterUtils.updateNotes(
                                      controller.current, [note]),
                                ),
                              ),
                              onDelete: _delete(
                                context,
                                note,
                                note.title,
                                tn(Note),
                                () => controller.updateCharacter(
                                  CharacterUtils.removeNotes(
                                      controller.current, [note]),
                                ),
                              ),
                            ),
                          ],
                          onSave: (note) {
                            controller.updateCharacter(
                              CharacterUtils.updateNotes(
                                  controller.current, [note]),
                            );
                            if (!note.favorite) {
                              Get.back();
                            }
                          },
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
            //
            // MOVES
            //
            if (moves.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(tr.home.categories.moves),
              ),
            Builder(builder: (context) {
              final raceCardMini = controller.current.race.favorite
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
                                  abilityScores:
                                      controller.current.abilityScores,
                                  race: controller.current.race,
                                  onSave: (race) => controller.updateCharacter(
                                    controller.current.copyWith(race: race),
                                  ),
                                ),
                                onDelete: null,
                              ),
                            ],
                            onSave: (race) => controller.updateCharacter(
                              controller.current.copyWith(race: race),
                            ),
                          ),
                        ),
                      ),
                      onSave: (race) => controller.updateCharacter(
                        controller.current.copyWith(race: race),
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
                    onSave: (move) => controller.updateCharacter(
                      CharacterUtils.updateMoves(controller.current, [move]),
                    ),
                    abilityScores: controller.current.abilityScores,
                  ),
                ),
                expandedCardBuilder: (context, move, index) => Obx(
                  () => moves.isNotEmpty && index < moves.length
                      ? MoveCard(
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
                                onSave: (move) => library.upsertToCharacter(
                                    [move],
                                    forkBehavior: ForkBehavior.increaseVersion),
                              ),
                              onDelete: _delete(
                                context,
                                move,
                                move.name,
                                tn(Move),
                                () => controller.updateCharacter(
                                  CharacterUtils.removeMoves(
                                      controller.current, [move]),
                                ),
                              ),
                            ),
                          ],
                          onSave: (move) {
                            controller.updateCharacter(
                              CharacterUtils.updateMoves(
                                  controller.current, [move]),
                            );
                            if (!move.favorite) {
                              Get.back();
                            }
                          },
                        )
                      : const SizedBox.shrink(),
                ),
                leading: raceCardMini != null &&
                        controller.current.settings.racePosition ==
                            RacePosition.start
                    ? [raceCardMini]
                    : [],
                trailing: raceCardMini != null &&
                        controller.current.settings.racePosition ==
                            RacePosition.end
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
                child: Text(tr.home.categories.spells),
              ),
            ],
            HorizontalCardListView<Spell>(
              cardSize: cardSize,
              items: spells,
              cardBuilder: (context, spell, index, onTap) => Obx(
                () => SpellCardMini(
                  spell: spells[index],
                  onTap: onTap,
                  onSave: (spell) => controller.updateCharacter(
                    CharacterUtils.updateSpells(controller.current, [spell]),
                  ),
                  abilityScores: controller.current.abilityScores,
                ),
              ),
              expandedCardBuilder: (context, spell, index) => Obx(
                () => spells.isNotEmpty && index < spells.length
                    ? SpellCard(
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
                                CharacterUtils.updateSpells(
                                    controller.current, [spell]),
                              ),
                            ),
                            onDelete: _delete(
                              context,
                              spell,
                              spell.name,
                              tn(Spell),
                              () => controller.updateCharacter(
                                CharacterUtils.removeSpells(
                                    controller.current, [spell]),
                              ),
                            ),
                          ),
                        ],
                        onSave: (spell) {
                          controller.updateCharacter(
                            CharacterUtils.updateSpells(
                                controller.current, [spell]),
                          );
                          if (!spell.prepared) {
                            Get.back();
                          }
                        },
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            //
            // ITEMS
            //
            if (items.isNotEmpty) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(tr.home.categories.items),
              ),
            ],
            HorizontalCardListView<Item>(
              cardSize: cardSize,
              items: items,
              cardBuilder: (context, item, index, onTap) => Obx(
                () => ItemCardMini(
                  item: items[index],
                  onTap: onTap,
                  onSave: (item) => controller.updateCharacter(
                    CharacterUtils.updateItems(controller.current, [item]),
                  ),
                ),
              ),
              expandedCardBuilder: (context, item, index) => Obx(
                () => items.isNotEmpty && index < items.length
                    ? ItemCard(
                        maxContentHeight: maxContentHeight,
                        expandable: false,
                        initiallyExpanded: true,
                        item: items[index],
                        actions: [
                          EntityEditMenu(
                            onEdit: () => ModelPages.openItemPage(
                              item: items[index],
                              onSave: (item) => controller.updateCharacter(
                                CharacterUtils.updateItems(
                                    controller.current, [item]),
                              ),
                            ),
                            onDelete: _delete(
                              context,
                              item,
                              item.name,
                              tn(Item),
                              () => controller.updateCharacter(
                                CharacterUtils.removeItems(
                                    controller.current, [item]),
                              ),
                            ),
                            leading: [
                              ChecklistMenuEntry(
                                value: 'countArmor',
                                checked: item.settings.countArmor,
                                label: Text(tr.items.settings.countArmor),
                                onChanged: (value) =>
                                    controller.updateCharacter(
                                  CharacterUtils.updateItems(
                                      controller.current, [
                                    item.copyWithInherited(
                                      settings: item.settings
                                          .copyWith(countArmor: value!),
                                    )
                                  ]),
                                ),
                              ),
                              ChecklistMenuEntry(
                                value: 'countDamage',
                                checked: item.settings.countDamage,
                                label: Text(tr.items.settings.countDamage),
                                onChanged: (value) =>
                                    controller.updateCharacter(
                                  CharacterUtils.updateItems(
                                      controller.current, [
                                    item.copyWithInherited(
                                      settings: item.settings
                                          .copyWith(countDamage: value!),
                                    )
                                  ]),
                                ),
                              ),
                              ChecklistMenuEntry(
                                value: 'countWeight',
                                checked: item.settings.countWeight,
                                label: Text(tr.items.settings.countWeight),
                                onChanged: (value) =>
                                    controller.updateCharacter(
                                  CharacterUtils.updateItems(
                                      controller.current, [
                                    item.copyWithInherited(
                                      settings: item.settings
                                          .copyWith(countWeight: value!),
                                    )
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ],
                        onSave: (item) {
                          controller.updateCharacter(
                            CharacterUtils.updateItems(
                                controller.current, [item]),
                          );
                          if (!item.equipped) {
                            Get.back();
                          }
                        },
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ]),
    );
  }

  void Function() _delete<T>(BuildContext context, T item, String itemName,
      String typeName, void Function() onRemove) {
    return () => deleteDialog.confirm(
          context,
          DeleteDialogOptions(
              entityName: itemName, entityKind: tr.entity(typeName)),
          () {
            onRemove();
            Get.back();
          },
        );
  }
}
