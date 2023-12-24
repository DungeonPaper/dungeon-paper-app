import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/data/services/library_provider.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/BioForm/controllers/bio_form_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/checklist_menu_entry.dart';
import 'package:dungeon_paper/app/widgets/cards/alignment_value_card.dart';
import 'package:dungeon_paper/app/widgets/cards/alignment_value_card_mini.dart';
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

import '../expanded_card_dialog_view.dart';
import 'horizontal_list_card_view.dart';

class HomeCharacterDynamicCards extends StatelessWidget
    with CharacterProviderMixin {
  const HomeCharacterDynamicCards({super.key});

  List<Move> get moves =>
      (maybeChar?.moves ?? <Move>[]).where((m) => m.favorite).toList();
  List<Spell> get spells => (charProvider.maybeCurrent?.spells ?? <Spell>[])
      .where((m) => m.prepared)
      .toList();
  List<Item> get items =>
      (maybeChar?.items ?? <Item>[]).where((m) => m.equipped).toList();
  List<Note> get notes =>
      (maybeChar?.notes ?? <Note>[]).where((n) => n.favorite).toList();
  List<WithMeta> get classActions => maybeChar?.classActions ?? [];
  double maxContentHeight(BuildContext context) =>
      MediaQuery.of(context).size.height - 250;

  static const cardSize = Size(210, 151);

  @override
  Widget build(BuildContext context) {
    return CharacterProvider.consumer(
      (context, controller, _) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...controller.current.actionCategories.map(
            (cat) {
              return _buildList(context, controller, cat);
            },
          ).reduce((value, element) => value + element),
        ],
      ),
    );
  }

  List<Widget> _buildList(
      BuildContext context, CharacterProvider controller, String cat) {
    switch (cat) {
      case 'ClassAction':
        return _classActionsList(context, controller);
      case 'Move':
        return _movesList(context, controller);
      case 'Spell':
        return _spellsList(context, controller);
      case 'Item':
        return _itemsList(context, controller);
    }

    return [const SizedBox.shrink()];
  }

  List<Widget> classActionCardsMini(
      BuildContext context, CharacterProvider charProvider) {
    final raceCard = RaceCardMini(
      race: charProvider.current.race,
      onTap: () => showDialog(
        context: context,
        builder: (context) => ExpandedCardDialogView<Race>(
          // heroTag: getKeyFor(item.value),
          heroTag: null,
          builder: (context) => RaceCard(
            maxContentHeight: maxContentHeight(context),
            expandable: false,
            initiallyExpanded: true,
            race: charProvider.current.race,
            actions: [
              EntityEditMenu(
                onEdit: () => ModelPages.openRacePage(
                  context,
                  abilityScores: charProvider.current.abilityScores,
                  race: charProvider.current.race,
                  onSave: (race) => charProvider.updateCharacter(
                    charProvider.current.copyWith(race: race),
                  ),
                ),
                onDelete: null,
              ),
            ],
            onSave: (race) => charProvider.updateCharacter(
              charProvider.current.copyWith(race: race),
            ),
          ),
        ),
      ),
      onSave: (race) => charProvider.updateCharacter(
        charProvider.current.copyWith(race: race),
      ),
    );
    final alignmentCard = AlignmentValueCardMini(
      alignment: char.bio.alignment,
      onTap: () => showDialog(
        context: context,
        builder: (context) => ExpandedCardDialogView<Race>(
          // heroTag: getKeyFor(item.value),
          heroTag: null,
          builder: (context) => AlignmentValueCard(
            maxContentHeight: maxContentHeight(context),
            expandable: false,
            initiallyExpanded: true,
            alignment: char.bio.alignment,
            actions: [
              EntityEditMenu(
                onEdit: () => Navigator.of(context).pushNamed(
                  Routes.bio,
                  arguments: BioFormArguments(character: char),
                ),
                onDelete: null,
              ),
            ],
          ),
        ),
      ),
    );
    return [
      raceCard,
      alignmentCard,
    ];
  }

  List<Widget> classActionCards(
      BuildContext context, CharacterProvider charProvider) {
    final raceCard = RaceCard(
      race: char.race,
      onSave: (race) => charProvider.updateCharacter(
        char.copyWithInherited(race: race),
      ),
      actions: [
        EntityEditMenu(
          onDelete: null,
          onEdit: () => ModelPages.openRacePage(
            context,
            race: char.race,
            abilityScores: char.abilityScores,
            onSave: (race) => charProvider.updateCharacter(
              char.copyWithInherited(race: race),
            ),
          ),
        ),
      ],
    );
    final alignmentCard = AlignmentValueCard(
      alignment: char.bio.alignment,
      actions: [
        EntityEditMenu(
          onDelete: null,
          onEdit: () => Navigator.of(context).pushNamed(
            Routes.bio,
            arguments: BioFormArguments(character: char),
          ),
        ),
        ElevatedButton(
          onPressed: () => charProvider.updateCharacter(
            char.copyWith(
              stats: char.stats.copyWith(
                currentXp: char.stats.currentXp + 1,
              ),
            ),
          ),
          child: Text(tr.actions.classActions.markXP),
        ),
      ],
    );
    return [
      raceCard,
      alignmentCard,
    ];
  }

  void Function() _delete<T>(
    BuildContext context,
    T item,
    String itemName,
    String typeName,
    void Function() onRemove,
  ) {
    return () => awaitDeleteConfirmation(
          context,
          itemName,
          () {
            onRemove();
            Navigator.of(context).pop();
          },
          T,
        );
  }

  List<Widget> _notesList(BuildContext context, CharacterProvider controller) {
    return [
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
        cardBuilder: (context, note, index, onTap) => NoteCardMini(
          note: notes[index],
          onTap: onTap,
          onSave: (note) => controller.updateCharacter(
            CharacterUtils.updateNotes(controller.current, [note]),
          ),
        ),
        expandedCardBuilder: (context, note, index) => notes.isNotEmpty &&
                index < notes.length
            ? NoteCard(
                maxContentHeight: maxContentHeight(context),
                expandable: false,
                initiallyExpanded: true,
                note: notes[index],
                actions: [
                  EntityEditMenu(
                    onEdit: () => ModelPages.openNotePage(
                      context,
                      note: notes[index],
                      onSave: (note) => controller.updateCharacter(
                        CharacterUtils.updateNotes(controller.current, [note]),
                      ),
                    ),
                    onDelete: _delete(
                      context,
                      note,
                      note.title,
                      tn(Note),
                      () => controller.updateCharacter(
                        CharacterUtils.removeNotes(controller.current, [note]),
                      ),
                    ),
                  ),
                ],
                onSave: (note) {
                  controller.updateCharacter(
                    CharacterUtils.updateNotes(controller.current, [note]),
                  );
                  if (!note.favorite) {
                    Navigator.of(context).pop();
                  }
                },
              )
            : const SizedBox.shrink(),
      ),
    ];
  }

  List<Widget> _movesList(BuildContext context, CharacterProvider controller) {
    return [
      if (moves.isNotEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(tr.home.categories.moves),
        ),
      Builder(
        builder: (context) {
          return HorizontalCardListView<Move>(
            cardSize: cardSize,
            items: moves,
            cardBuilder: (context, move, index, onTap) => MoveCardMini(
              move: moves[index],
              onTap: onTap,
              onSave: (move) => controller.updateCharacter(
                CharacterUtils.updateMoves(controller.current, [move]),
              ),
              abilityScores: controller.current.abilityScores,
            ),
            expandedCardBuilder: (context, move, index) =>
                LibraryProvider.consumer(
              (context, library, _) {
                return moves.isNotEmpty && index < moves.length
                    ? MoveCard(
                        maxContentHeight: maxContentHeight(context),
                        expandable: false,
                        initiallyExpanded: true,
                        move: moves[index],
                        abilityScores: controller.current.abilityScores,
                        actions: [
                          EntityEditMenu(
                            onEdit: () => ModelPages.openMovePage(
                              context,
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
                            Navigator.of(context).pop();
                          }
                        },
                      )
                    : const SizedBox.shrink();
              },
            ),
            // leading: raceCardMini != null &&
            //         controller.current.settings.racePosition ==
            //             RacePosition.start
            //     ? [raceCardMini]
            //     : [],
            // trailing: raceCardMini != null &&
            //         controller.current.settings.racePosition ==
            //             RacePosition.end
            //     ? [raceCardMini]
            //     : [],
          );
        },
      ),
    ];
  }

  List<Widget> _spellsList(BuildContext context, CharacterProvider controller) {
    return [
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
        cardBuilder: (context, spell, index, onTap) => SpellCardMini(
          spell: spells[index],
          onTap: onTap,
          onSave: (spell) => controller.updateCharacter(
            CharacterUtils.updateSpells(controller.current, [spell]),
          ),
          abilityScores: controller.current.abilityScores,
        ),
        expandedCardBuilder: (context, spell, index) => spells.isNotEmpty &&
                index < spells.length
            ? SpellCard(
                maxContentHeight: maxContentHeight(context),
                expandable: false,
                initiallyExpanded: true,
                spell: spells[index],
                abilityScores: controller.current.abilityScores,
                actions: [
                  EntityEditMenu(
                    onEdit: () => ModelPages.openSpellPage(
                      context,
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
                    CharacterUtils.updateSpells(controller.current, [spell]),
                  );
                  if (!spell.prepared) {
                    Navigator.of(context).pop();
                  }
                },
              )
            : const SizedBox.shrink(),
      ),
    ];
  }

  List<Widget> _itemsList(BuildContext context, CharacterProvider controller) {
    return [
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
        cardBuilder: (context, item, index, onTap) => ItemCardMini(
          item: items[index],
          onTap: onTap,
          onSave: (item) => controller.updateCharacter(
            CharacterUtils.updateItems(controller.current, [item]),
          ),
        ),
        expandedCardBuilder: (context, item, index) => items.isNotEmpty &&
                index < items.length
            ? ItemCard(
                maxContentHeight: maxContentHeight(context),
                expandable: false,
                initiallyExpanded: true,
                item: items[index],
                actions: [
                  EntityEditMenu(
                    onEdit: () => ModelPages.openItemPage(
                      context,
                      item: items[index],
                      onSave: (item) => controller.updateCharacter(
                        CharacterUtils.updateItems(controller.current, [item]),
                      ),
                    ),
                    onDelete: _delete(
                      context,
                      item,
                      item.name,
                      tn(Item),
                      () => controller.updateCharacter(
                        CharacterUtils.removeItems(controller.current, [item]),
                      ),
                    ),
                    leading: [
                      ChecklistMenuEntry(
                        value: 'countArmor',
                        checked: item.settings.countArmor,
                        label: Text(tr.items.settings.countArmor),
                        onChanged: (value) => controller.updateCharacter(
                          CharacterUtils.updateItems(controller.current, [
                            item.copyWithInherited(
                              settings:
                                  item.settings.copyWith(countArmor: value!),
                            )
                          ]),
                        ),
                      ),
                      ChecklistMenuEntry(
                        value: 'countDamage',
                        checked: item.settings.countDamage,
                        label: Text(tr.items.settings.countDamage),
                        onChanged: (value) => controller.updateCharacter(
                          CharacterUtils.updateItems(controller.current, [
                            item.copyWithInherited(
                              settings:
                                  item.settings.copyWith(countDamage: value!),
                            )
                          ]),
                        ),
                      ),
                      ChecklistMenuEntry(
                        value: 'countWeight',
                        checked: item.settings.countWeight,
                        label: Text(tr.items.settings.countWeight),
                        onChanged: (value) => controller.updateCharacter(
                          CharacterUtils.updateItems(controller.current, [
                            item.copyWithInherited(
                              settings:
                                  item.settings.copyWith(countWeight: value!),
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                ],
                onSave: (item) {
                  controller.updateCharacter(
                    CharacterUtils.updateItems(controller.current, [item]),
                  );
                  if (!item.equipped) {
                    Navigator.of(context).pop();
                  }
                },
              )
            : const SizedBox.shrink(),
      ),
    ];
  }

  List<Widget> _classActionsList(
      BuildContext context, CharacterProvider controller) {
    return [
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(tr.home.categories.classActions),
      ),
      HorizontalCardListView<WithMeta>(
        cardSize: cardSize,
        items: classActions,
        cardBuilder: (context, item, index, onTap) =>
            classActionCardsMini(context, controller)[index],
        expandedCardBuilder: (context, item, index) =>
            classActionCards(context, controller)[index],
      ),
    ];
  }
}

