import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_settings.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/data/services/library_provider.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/BioForm/controllers/bio_form_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/items_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/moves_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/spells_library_list_view.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/checklist_menu_entry.dart';
import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/app/widgets/cards/alignment_value_card.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/race_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/chips/move_category_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/app/widgets/menus/group_sort_menu.dart';
import 'package:dungeon_paper/app/widgets/molecules/categorized_list.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import 'local_widgets/home_character_actions_summary.dart';

class HomeCharacterActionsView extends StatelessWidget
    with CharacterProviderMixin {
  const HomeCharacterActionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: PageStorageBucket(),
      child: CharacterProvider.consumer((context, controller, _) {
        if (controller.maybeCurrent == null) {
          return Container();
        }
        final builder = _getBuilder(controller);
        return SizedBox(
          child: builder.asListView(padding: const EdgeInsets.only(bottom: 16)),
        );
      }),
    );
  }

  ItemBuilder _getBuilder(CharacterProvider ctrl) {
    final char = ctrl.current;
    return ItemBuilder.builder(
      leadingBuilder: (context, index) => const HomeCharacterActionsSummary(),
      leadingCount: 1,
      itemCount: char.actionCategories.length,
      itemBuilder: (context, index) {
        return Center(
          child: SizedBox(
            width: 800,
            child: Builder(
              builder: (context) {
                switch (char.actionCategories.elementAt(index)) {
                  case 'ClassAction':
                    return classActionsList(context, ctrl) ??
                        const SizedBox.shrink();
                  case 'Move':
                    return movesList(context, ctrl) ?? const SizedBox.shrink();
                  case 'Spell':
                    return spellsList(context, ctrl) ?? const SizedBox.shrink();
                  case 'Item':
                    return itemsList(context, ctrl) ?? const SizedBox.shrink();
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );
  }

  Widget? classActionsList(BuildContext context, CharacterProvider controller) {
    if (char.settings.actionCategories.hidden.contains('ClassAction')) {
      return null;
    }
    final raceCard = RaceCard(
      race: char.race,
      onSave:
          (race) =>
              controller.updateCharacter(char.copyWithInherited(race: race)),
      actions: [
        EntityEditMenu(
          onDelete: null,
          onEdit:
              () => ModelPages.openRacePage(
                context,
                race: char.race,
                abilityScores: char.abilityScores,
                onSave:
                    (race) => controller.updateCharacter(
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
    final list = [raceCard, alignmentCard];
    final index = char.actionCategories.toList().indexOf('ClassAction');
    return CategorizedList(
      initiallyExpanded: true,
      title: Text(tr.actions.classActions.title),
      titleTrailing: [
        GroupSortMenu(
          index: index,
          totalItemCount: Character.allActionCategories.length,
          onReorder: _onReorder,
        ),
      ],
      itemPadding: const EdgeInsets.only(bottom: 8),
      children: [
        ...list.map((obj) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            key: PageStorageKey('type-ClassAction-${obj.key}'),
            child: obj,
          );
        }),
      ],
    );
  }

  Widget? movesList(BuildContext context, CharacterProvider controller) {
    if (char.settings.actionCategories.hidden.contains('Move')) {
      return null;
    }
    return ActionsCardList<Move>(
      index: char.actionCategories.toList().indexOf('Move'),
      typeName: tn(Move),
      onReorder: _onReorder,
      list: char.moves,
      route: Routes.moves,
      leading: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => _openBasicMoves(context),
                child: Text(tr.actions.moves.basic),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _openSpecialMoves(context),
                child: Text(tr.actions.moves.special),
              ),
            ),
          ],
        ),
        const SizedBox(height: 0),
        const Divider(height: 1),
        const SizedBox(height: 4),
      ],
      menuTrailing: [
        if (char.settings.racePosition != RacePosition.start)
          // Move to start of list
          MenuEntry(
            value: 'move_to_start',
            label: Text(tr.sort.moveEntityToTop(tr.entity(tn(Race)))),
            onSelect:
                () => controller.updateCharacter(
                  char.copyWith(
                    settings: char.settings.copyWith(
                      racePosition: RacePosition.start,
                    ),
                  ),
                ),
          ),
        if (char.settings.racePosition != RacePosition.end)
          // Move to end of list
          MenuEntry(
            value: 'move_to_end',
            label: Text(tr.sort.moveEntityToBottom(tr.entity(tn(Race)))),
            onSelect:
                () => controller.updateCharacter(
                  char.copyWith(
                    settings: char.settings.copyWith(
                      racePosition: RacePosition.end,
                    ),
                  ),
                ),
          ),
      ],
      addPageArguments:
          ({required onSelected}) => MoveLibraryListArguments(
            character: char,
            onSelected: onSelected,
            preSelections: char.moves,
          ),
      cardBuilder:
          (move, {required onSave, required onDelete}) => MoveCard(
            reorderablePadding: true,
            move: move,
            advancedLevelDisplay: AdvancedLevelDisplay.none,
            abilityScores: char.abilityScores,
            actions: [
              EntityEditMenu(
                onDelete: onDelete,
                onEdit:
                    () => ModelPages.openMovePage(
                      context,
                      move: move,
                      abilityScores: char.abilityScores,
                      onSave: onSave(true),
                    ),
              ),
            ],
            onSave: onSave(false),
          ),
    );
  }

  Widget? spellsList(BuildContext context, CharacterProvider controller) {
    if (char.settings.actionCategories.hidden.contains('Spell')) {
      return null;
    }
    return ActionsCardList<Spell>(
      index: char.actionCategories.toList().indexOf('Spell'),
      typeName: tn(Spell),
      onReorder: _onReorder,
      list: char.spells,
      route: Routes.spells,
      addPageArguments:
          ({required onSelected}) => SpellLibraryListArguments(
            character: char,
            onSelected: onSelected,
            preSelections: char.spells,
          ),
      cardBuilder:
          (spell, {required onSave, required onDelete}) => SpellCard(
            reorderablePadding: true,
            spell: spell,
            abilityScores: char.abilityScores,
            actions: [
              EntityEditMenu(
                onDelete: onDelete,
                onEdit:
                    () => ModelPages.openSpellPage(
                      context,
                      spell: spell,
                      classKeys: spell.classKeys,
                      abilityScores: char.abilityScores,
                      onSave: onSave(true),
                    ),
              ),
            ],
            onSave: onSave(false),
          ),
    );
  }

  Widget? itemsList(BuildContext context, CharacterProvider controller) {
    if (char.settings.actionCategories.hidden.contains('Item')) {
      return null;
    }
    return ActionsCardList<Item>(
      index: char.actionCategories.toList().indexOf('Item'),
      typeName: tn(Item),
      onReorder: _onReorder,
      list: char.items,
      route: Routes.items,
      addPageArguments:
          ({required onSelected}) => ItemLibraryListArguments(
            onSelected:
                (items) => onSelected(
                  items
                      .map(
                        (x) => x.copyWithInherited(
                          amount: x.amount == 0 ? 1 : x.amount,
                        ),
                      )
                      .toList(),
                ),
            preSelections: char.items,
          ),
      cardBuilder:
          (item, {required onSave, required onDelete}) => ItemCard(
            reorderablePadding: true,
            item: item,
            actions: [
              EntityEditMenu(
                onDelete: onDelete,
                onEdit:
                    () => ModelPages.openItemPage(
                      context,
                      item: item,
                      onSave: onSave(true),
                    ),
                leading: [
                  ChecklistMenuEntry(
                    value: 'countArmor',
                    checked: item.settings.countArmor,
                    label: Text(tr.items.settings.countArmor),
                    onChanged:
                        (value) => onSave(false)(
                          item.copyWithInherited(
                            settings: item.settings.copyWith(
                              countArmor: value!,
                            ),
                          ),
                        ),
                  ),
                  ChecklistMenuEntry(
                    value: 'countDamage',
                    checked: item.settings.countDamage,
                    label: Text(tr.items.settings.countDamage),
                    onChanged:
                        (value) => onSave(false)(
                          item.copyWithInherited(
                            settings: item.settings.copyWith(
                              countDamage: value!,
                            ),
                          ),
                        ),
                  ),
                  ChecklistMenuEntry(
                    value: 'countWeight',
                    checked: item.settings.countWeight,
                    label: Text(tr.items.settings.countWeight),
                    onChanged:
                        (value) => onSave(false)(
                          item.copyWithInherited(
                            settings: item.settings.copyWith(
                              countWeight: value!,
                            ),
                          ),
                        ),
                  ),
                ],
              ),
            ],
            onSave: onSave(false),
          ),
    );
  }

  void _onReorder(BuildContext context, int oldIndex, int newIndex) {
    charProvider.updateCharacter(
      char.copyWith(
        settings: char.settings.copyWith(
          actionCategories: char.settings.actionCategories.copyWithInherited(
            sortOrder: Set.from(
              reorder(
                char.actionCategories.toList(),
                oldIndex,
                newIndex,
                useReorderableOffset: false,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openBasicMoves(BuildContext context) {
    ModelPages.openStandardMovesList(
      context,
      category: MoveCategory.basic,
      character: char,
    );
  }

  void _openSpecialMoves(BuildContext context) {
    ModelPages.openStandardMovesList(
      context,
      category: MoveCategory.special,
      character: char,
    );
  }
}

class ActionsCardList<T extends WithMeta> extends StatelessWidget
    with CharacterProviderMixin {
  const ActionsCardList({
    super.key,
    required this.route,
    required this.typeName,
    required this.addPageArguments,
    required this.cardBuilder,
    required this.list,
    required this.index,
    required this.onReorder,
    this.menuLeading = const [],
    this.menuTrailing = const [],
    this.leading = const [],
    this.trailing = const [],
  });

  final String route;
  final String typeName;
  final List<Widget> leading;
  final List<Widget> trailing;
  final LibraryListArguments<T, EntityFilters<T>> Function({
    required void Function(Iterable<T> obj) onSelected,
  })
  addPageArguments;
  final Widget Function(
    T object, {
    required void Function() onDelete,
    required void Function(T object) Function(bool fork) onSave,
    // required void Function() onEdit,
  })
  cardBuilder;
  final List<T> list;
  final int index;
  final void Function(BuildContext context, int oldIndex, int newIndex)
  onReorder;
  final List<MenuEntry<String>> menuLeading;
  final List<MenuEntry<String>> menuTrailing;

  @override
  Widget build(BuildContext context) {
    return CharacterProvider.consumer((context, controller, _) {
      debugPrint('ActionsCardList rebuild');
      debugPrint(
        'Character items: \n${controller.current.items.map((e) => '- ${e.displayName}').join('\n')}',
      );
      return CategorizedList(
        initiallyExpanded: true,
        title: Text(tr.entityPlural(typeName)),
        itemPadding: const EdgeInsets.only(bottom: 8),
        titleTrailing: [
          LibraryProvider.consumer(
            (context, library, _) => TextButton.icon(
              onPressed:
                  () => Navigator.pushNamed(
                    context,
                    route,
                    arguments: addPageArguments(
                      onSelected:
                          (items) => library.upsertToCharacter(
                            items,
                            forkBehavior: ForkBehavior.fork,
                          ),
                    ),
                  ),
              label: Text(tr.generic.addEntity(tr.entityPlural(typeName))),
              icon: const Icon(Icons.add),
            ),
          ),
          GroupSortMenu(
            index: index,
            totalItemCount: Character.allActionCategories.length,
            onReorder: onReorder,
            leading: menuLeading,
            trailing: menuTrailing,
          ),
        ],
        leading: leading.map((obj) => _wrapChild(child: obj)).toList(),
        trailing: trailing.map((obj) => _wrapChild(child: obj)).toList(),
        children: [
          ...list.map((obj) {
            return _wrapChild(
              key: PageStorageKey('type-$T-${obj.key}'),
              child: cardBuilder(
                obj,
                onDelete: _confirmDeleteDlg(context, obj, obj.displayName),
                onSave:
                    (fork) => (obj) {
                      final library = LibraryProvider.of(context);
                      library.upsertToCharacter([
                        obj,
                      ], forkBehavior: ForkBehavior.none);
                    },
              ),
            );
          }),
        ],
        onReorder:
            (oldIndex, newIndex) => controller.updateCharacter(
              CharacterUtils.reorderByType<T>(
                controller.current,
                oldIndex,
                newIndex,
              ),
            ),
      );
    });
  }

  Widget _wrapChild({Key? key, required Widget child}) => Padding(
    key: key,
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: child,
  );

  void Function() _confirmDeleteDlg(
    BuildContext context,
    T object,
    String name,
  ) {
    return () {
      awaitDeleteConfirmation<T>(
        context,
        name,
        () => charProvider.updateCharacter(
          CharacterUtils.removeByType<T>(char, [object]),
        ),
      );
    };
  }
}
