import 'package:dungeon_paper/app/data/models/character_settings.dart';
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
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import '../expanded_card_dialog_view.dart';
import 'horizontal_list_card_view.dart';

class HomeCharacterDynamicCards extends StatelessWidget
    with CharacterProviderMixin {
  const HomeCharacterDynamicCards({super.key});

  List<Move> get moves =>
      (maybeChar?.moves ?? <Move>[]).where((m) => m.favorite).toList();
  List<Spell> get spells =>
      (charProvider.maybeCurrent?.spells ?? <Spell>[])
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...{...controller.current.actionCategories, 'Note'}
              .map((cat) => _buildListByType(context, controller, cat))
              .reduce((value, element) => value + element),
        ],
      ),
    );
  }

  List<Widget> _buildListByType(
    BuildContext context,
    CharacterProvider controller,
    String cat,
  ) {
    switch (cat) {
      case 'ClassAction':
        return _classActionsList(context, controller);
      case 'Move':
        return _movesList(context, controller);
      case 'Spell':
        return _spellsList(context, controller);
      case 'Item':
        return _itemsList(context, controller);
      case 'Note':
        return _notesList(context, controller);
    }

    return [const SizedBox.shrink()];
  }

  List<Widget> classActionCardsMini(
    BuildContext context,
    CharacterProvider charProvider,
  ) {
    final raceCard = RaceCardMini(
      race: charProvider.current.race,
      onTap:
          () => showDialog(
            context: context,
            builder:
                (context) => ExpandedCardDialogView<Race>(
                  // heroTag: getKeyFor(item.value),
                  heroTag: null,
                  builder:
                      (context) => RaceCard(
                        maxContentHeight: maxContentHeight(context),
                        expandable: false,
                        initiallyExpanded: true,
                        race: charProvider.current.race,
                        actions: [
                          EntityEditMenu(
                            onEdit:
                                () => ModelPages.openRacePage(
                                  context,
                                  abilityScores:
                                      charProvider.current.abilityScores,
                                  race: charProvider.current.race,
                                  onSave:
                                      (race) => charProvider.updateCharacter(
                                        charProvider.current.copyWith(
                                          race: race,
                                        ),
                                      ),
                                ),
                            onDelete: null,
                          ),
                        ],
                        onSave:
                            (race) => charProvider.updateCharacter(
                              charProvider.current.copyWith(race: race),
                            ),
                      ),
                ),
          ),
      onSave:
          (race) => charProvider.updateCharacter(
            charProvider.current.copyWith(race: race),
          ),
    );
    final alignmentCard = AlignmentValueCardMini(
      alignment: char.bio.alignment,
      onTap:
          () => showDialog(
            context: context,
            builder:
                (context) => ExpandedCardDialogView<Race>(
                  // heroTag: getKeyFor(item.value),
                  heroTag: null,
                  builder:
                      (context) => AlignmentValueCard(
                        maxContentHeight: maxContentHeight(context),
                        expandable: false,
                        initiallyExpanded: true,
                        alignment: char.bio.alignment,
                        actions: [
                          EntityEditMenu(
                            onEdit:
                                () => Navigator.of(context).pushNamed(
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
    return [raceCard, alignmentCard];
  }

  List<Widget> classActionCards(
    BuildContext context,
    CharacterProvider charProvider, {
    required bool expandable,
  }) {
    final raceCard = RaceCard(
      race: char.race,
      onSave:
          (race) =>
              charProvider.updateCharacter(char.copyWithInherited(race: race)),
      actions: [
        EntityEditMenu(
          onDelete: null,
          onEdit:
              () => ModelPages.openRacePage(
                context,
                race: char.race,
                abilityScores: char.abilityScores,
                onSave:
                    (race) => charProvider.updateCharacter(
                      char.copyWithInherited(race: race),
                    ),
              ),
        ),
      ],
    );
    final alignmentCard = AlignmentValueCard(
      alignment: char.bio.alignment,
      expandable: expandable,
      initiallyExpanded: !expandable,
      actions: [
        EntityEditMenu(
          onDelete: null,
          onEdit:
              () => Navigator.of(context).pushNamed(
                Routes.bio,
                arguments: BioFormArguments(character: char),
              ),
        ),
        ElevatedButton(
          onPressed: () => CharacterUtils.addXP(context, char, 1),
          child: Text(tr.actions.classActions.markXP.button),
        ),
      ],
    );
    return [raceCard, alignmentCard];
  }

  void Function() _delete<T>(
    BuildContext context,
    T item,
    String itemName,
    String typeName,
    void Function() onRemove,
  ) {
    return () => awaitDeleteConfirmation(context, itemName, () {
      onRemove();
      Navigator.of(context).pop();
    }, T);
  }

  List<Widget> _listViewBuilder<T extends WithMeta>(
    BuildContext context,
    CharacterProvider controller, {
    required List<T> list,
    required Widget Function(BuildContext, LibraryProvider, T) cardBuilder,
    required Widget Function(BuildContext, LibraryProvider, T, VoidCallback)
    cardMiniBuilder,
    required Widget Function(BuildContext, LibraryProvider, T)
    expandedCardBuilder,
    required String title,
  }) {
    if (list.isEmpty) {
      return [];
    }
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 10),
        child: Text(title),
      ),
      Builder(
        builder: (context) {
          if (char.settings.favoritesView == FavoritesView.list) {
            return Column(
              children: [
                for (final item in list)
                  Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: LibraryProvider.consumer(
                      (context, library, _) =>
                          cardBuilder(context, library, item),
                    ),
                  ),
              ],
            );
          }
          return HorizontalCardListView<T>(
            cardSize: cardSize,
            items: list,
            cardBuilder:
                (context, item, index, onTap) => LibraryProvider.consumer(
                  (context, library, _) =>
                      cardMiniBuilder(context, library, item, onTap),
                ),
            expandedCardBuilder:
                (context, item, index) => LibraryProvider.consumer(
                  (context, library, _) =>
                      list.isNotEmpty && index < list.length
                          ? expandedCardBuilder(context, library, item)
                          : SizedBox.shrink(),
                ),
          );
        },
      ),
    ];
  }

  List<Widget> _notesList(BuildContext context, CharacterProvider controller) {
    onSave(Note note) => controller.updateCharacter(
      CharacterUtils.updateNotes(controller.current, [note]),
    );
    actions(LibraryProvider library, Note note) => [
      EntityEditMenu(
        onEdit:
            () => ModelPages.openNotePage(context, note: note, onSave: onSave),
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
    ];

    return _listViewBuilder<Note>(
      context,
      controller,
      title: tr.home.categories.notes,
      list: notes,
      cardMiniBuilder:
          (context, library, note, onTap) =>
              NoteCardMini(note: note, onTap: onTap, onSave: onSave),
      cardBuilder:
          (context, library, note) => NoteCard(
            note: note,
            onSave: onSave,
            actions: actions(library, note),
          ),
      expandedCardBuilder:
          (context, library, note) => NoteCard(
            maxContentHeight: maxContentHeight(context),
            expandable: false,
            initiallyExpanded: true,
            note: note,
            actions: actions(library, note),
            onSave: (note) {
              onSave(note);
              if (!note.favorite) {
                Navigator.of(context).pop();
              }
            },
          ),
    );
  }

  List<Widget> _movesList(BuildContext context, CharacterProvider controller) {
    onSave(Move move) => controller.updateCharacter(
      CharacterUtils.updateMoves(controller.current, [move]),
    );
    actions(LibraryProvider library, Move move) => [
      EntityEditMenu(
        onEdit:
            () => ModelPages.openMovePage(
              context,
              abilityScores: controller.current.abilityScores,
              move: move,
              onSave: onSave,
            ),
        onDelete: _delete(
          context,
          move,
          move.name,
          tn(Move),
          () => controller.updateCharacter(
            CharacterUtils.removeMoves(controller.current, [move]),
          ),
        ),
      ),
    ];
    return _listViewBuilder<Move>(
      context,
      controller,
      title: tr.home.categories.moves,
      list: moves,
      cardMiniBuilder:
          (context, library, move, onTap) => MoveCardMini(
            move: move,
            onTap: onTap,
            onSave: onSave,
            abilityScores: controller.current.abilityScores,
          ),
      cardBuilder:
          (context, library, move) => MoveCard(
            move: move,
            onSave: onSave,
            abilityScores: controller.current.abilityScores,
            actions: actions(library, move),
          ),
      expandedCardBuilder:
          (context, library, move) => MoveCard(
            maxContentHeight: maxContentHeight(context),
            expandable: false,
            initiallyExpanded: true,
            move: move,
            abilityScores: controller.current.abilityScores,
            actions: actions(library, move),
            onSave: (move) {
              controller.updateCharacter(
                CharacterUtils.updateMoves(controller.current, [move]),
              );
              if (!move.favorite) {
                Navigator.of(context).pop();
              }
            },
          ),
    );
  }

  List<Widget> _spellsList(BuildContext context, CharacterProvider controller) {
    onSave(Spell spell) => controller.updateCharacter(
      CharacterUtils.updateSpells(controller.current, [spell]),
    );
    actions(LibraryProvider library, Spell spell) => [
      EntityEditMenu(
        onEdit:
            () => ModelPages.openSpellPage(
              context,
              abilityScores: controller.current.abilityScores,
              classKeys: spell.classKeys,
              spell: spell,
              onSave: onSave,
            ),
        onDelete: _delete(
          context,
          spell,
          spell.name,
          tn(Spell),
          () => controller.updateCharacter(
            CharacterUtils.removeSpells(controller.current, [spell]),
          ),
        ),
      ),
    ];
    return _listViewBuilder<Spell>(
      context,
      controller,
      title: tr.home.categories.spells,
      list: spells,
      cardMiniBuilder:
          (context, library, spell, onTap) => SpellCardMini(
            spell: spell,
            onTap: onTap,
            onSave: onSave,
            abilityScores: controller.current.abilityScores,
          ),
      cardBuilder:
          (context, library, spell) => SpellCard(
            spell: spell,
            onSave: onSave,
            abilityScores: controller.current.abilityScores,
            actions: actions(library, spell),
          ),
      expandedCardBuilder:
          (context, library, spell) => SpellCard(
            maxContentHeight: maxContentHeight(context),
            expandable: false,
            initiallyExpanded: true,
            spell: spell,
            abilityScores: controller.current.abilityScores,
            actions: actions(library, spell),
            onSave: (spell) {
              onSave(spell);
              if (!spell.prepared) {
                Navigator.of(context).pop();
              }
            },
          ),
    );
  }

  List<Widget> _itemsList(BuildContext context, CharacterProvider controller) {
    onSave(Item item) => controller.updateCharacter(
      CharacterUtils.updateItems(controller.current, [item]),
    );

    actions(LibraryProvider library, Item item) => [
      EntityEditMenu(
        onEdit:
            () => ModelPages.openItemPage(
              context,
              item: item,
              onSave:
                  (item) => library.upsertToCharacter([
                    item,
                  ], forkBehavior: ForkBehavior.increaseVersion),
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
            onChanged:
                (value) => controller.updateCharacter(
                  CharacterUtils.updateItems(controller.current, [
                    item.copyWithInherited(
                      settings: item.settings.copyWith(countArmor: value!),
                    ),
                  ]),
                ),
          ),
          ChecklistMenuEntry(
            value: 'countDamage',
            checked: item.settings.countDamage,
            label: Text(tr.items.settings.countDamage),
            onChanged:
                (value) => controller.updateCharacter(
                  CharacterUtils.updateItems(controller.current, [
                    item.copyWithInherited(
                      settings: item.settings.copyWith(countDamage: value!),
                    ),
                  ]),
                ),
          ),
          ChecklistMenuEntry(
            value: 'countWeight',
            checked: item.settings.countWeight,
            label: Text(tr.items.settings.countWeight),
            onChanged:
                (value) => controller.updateCharacter(
                  CharacterUtils.updateItems(controller.current, [
                    item.copyWithInherited(
                      settings: item.settings.copyWith(countWeight: value!),
                    ),
                  ]),
                ),
          ),
        ],
      ),
    ];

    return _listViewBuilder<Item>(
      context,
      controller,
      title: tr.home.categories.items,
      list: items,
      cardMiniBuilder:
          (context, library, item, onTap) =>
              ItemCardMini(item: item, onTap: onTap, onSave: onSave),
      cardBuilder:
          (context, library, item) => ItemCard(
            item: item,
            onSave: onSave,
            actions: actions(library, item),
          ),
      expandedCardBuilder:
          (context, library, item) => ItemCard(
            maxContentHeight: maxContentHeight(context),
            expandable: false,
            initiallyExpanded: true,
            item: item,
            actions: actions(library, item),
            onSave: (item) {
              controller.updateCharacter(
                CharacterUtils.updateItems(controller.current, [item]),
              );
              if (!item.equipped) {
                Navigator.of(context).pop();
              }
            },
          ),
    );
  }

  List<Widget> _classActionsList(
    BuildContext context,
    CharacterProvider controller,
  ) {
    if (controller.current.classActions.isEmpty) {
      return [];
    }
    if (controller.current.settings.favoritesView == FavoritesView.list) {
      return [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(tr.home.categories.classActions),
        ),
        Column(
          children: [
            for (final item in enumerate(classActions))
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: LibraryProvider.consumer(
                  (context, library, _) =>
                      classActionCards(
                        context,
                        controller,
                        expandable: true,
                      )[item.index],
                ),
              ),
          ],
        ),
      ];
    }

    return [
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(tr.home.categories.classActions),
      ),
      HorizontalCardListView<WithMeta>(
        cardSize: cardSize,
        items: classActions,
        cardBuilder:
            (context, item, index, onTap) =>
                classActionCardsMini(context, controller)[index],
        expandedCardBuilder:
            (context, item, index) =>
                classActionCards(context, controller, expandable: false)[index],
      ),
    ];
  }
}
