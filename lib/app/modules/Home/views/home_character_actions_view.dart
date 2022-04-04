import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/bindings/add_repository_items_binding.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_items_view.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_moves_view.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_spells_view.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/filters/item_filters.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/filters/move_filters.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/filters/spell_filters.dart';
import 'package:dungeon_paper/app/modules/Home/views/local_widgets/home_character_actions_filters.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/app/widgets/menus/group_sort_menu.dart';
import 'package:dungeon_paper/app/widgets/molecules/categorized_list.dart';
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
            Obx(
              () => HomeCharacterActionsFiltersView(
                hidden: char.settings.actionCategoriesHide,
                onUpdateHidden: (filters) {
                  debugPrint('saving hide: $filters');
                  controller.updateCharacter(
                    char.copyWith(
                      settings: char.settings.copyWith(actionCategoriesHide: filters),
                    ),
                  );
                },
              ),
            ),
            for (final cat in char.actionCategories)
              {
                'Move': movesList,
                'Spell': spellsList,
                'Item': itemsList,
              }[cat],
          ].whereType<Widget>().toList(),
        );
      }),
    );
  }

  Widget? get movesList {
    if (char.settings.actionCategoriesHide.contains('Move')) {
      return null;
    }
    return ActionsCardList<Move>(
      index: char.actionCategories.toList().indexOf('Move'),
      onReorder: _onReorder,
      list: char.moves,
      addPageBuilder: ({required onAdd}) => AddMovesView(
        onAdd: onAdd,
        rollStats: char.rollStats,
        selections: char.moves,
        classKeys: [char.characterClass.key],
      ),
      addPageArguments: {
        FiltersGroup.playbook: MoveFilters(classKey: char.characterClass.key),
        FiltersGroup.my: MoveFilters(classKey: char.characterClass.key),
      },
      cardBuilder: (move, {required onSave, required onDelete}) => MoveCard(
        move: move,
        actions: [
          EntityEditMenu(
            onDelete: onDelete,
            onEdit: CharacterUtils.openMovePage(
              move: move,
              classKeys: move.classKeys,
              rollStats: char.rollStats,
              onSave: onSave,
            ),
          ),
        ],
        onSave: onSave,
      ),
    );
  }

  Widget? get spellsList {
    if (char.settings.actionCategoriesHide.contains('Spell')) {
      return null;
    }
    return ActionsCardList<Spell>(
      index: char.actionCategories.toList().indexOf('Spell'),
      onReorder: _onReorder,
      list: char.spells,
      addPageBuilder: ({required onAdd}) => AddSpellsView(
        onAdd: onAdd,
        rollStats: char.rollStats,
        selections: char.spells,
        classKeys: [char.characterClass.key],
      ),
      addPageArguments: {
        FiltersGroup.playbook: SpellFilters(classKey: char.characterClass.key),
        FiltersGroup.my: SpellFilters(classKey: char.characterClass.key),
      },
      cardBuilder: (spell, {required onSave, required onDelete}) => SpellCard(
        spell: spell,
        actions: [
          EntityEditMenu(
            onDelete: onDelete,
            onEdit: CharacterUtils.openSpellPage(
              spell: spell,
              classKeys: spell.classKeys,
              rollStats: char.rollStats,
              onSave: onSave,
            ),
          ),
        ],
        onSave: onSave,
      ),
    );
  }

  Widget? get itemsList {
    if (char.settings.actionCategoriesHide.contains('Item')) {
      return null;
    }
    return ActionsCardList<Item>(
      index: char.actionCategories.toList().indexOf('Item'),
      onReorder: _onReorder,
      list: char.items,
      addPageBuilder: ({required onAdd}) => AddItemsView(
        onAdd: onAdd,
        selections: char.items,
      ),
      addPageArguments: {
        FiltersGroup.playbook: ItemFilters(),
        FiltersGroup.my: ItemFilters(),
      },
      cardBuilder: (item, {required onSave, required onDelete}) => ItemCard(
        item: item,
        actions: [
          EntityEditMenu(
            onDelete: onDelete,
            onEdit: CharacterUtils.openItemPage(
              item: item,
              onSave: onSave,
            ),
          ),
        ],
        onSave: onSave,
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    controller.updateCharacter(
      char.copyWith(
        settings: char.settings.copyWith(
          actionCategoriesSort: Set.from(
            reorder(
              char.actionCategories.toList(),
              oldIndex,
              newIndex,
              useReorderableOffset: false,
            ),
          ),
        ),
      ),
    );
  }
}

class ActionsCardList<T> extends GetView<CharacterService> {
  const ActionsCardList({
    Key? key,
    required this.addPageBuilder,
    this.addPageArguments,
    required this.cardBuilder,
    required this.list,
    required this.index,
    required this.onReorder,
  }) : super(key: key);

  final Widget Function({
    required void Function(Iterable<T> obj) onAdd,
  }) addPageBuilder;
  final dynamic addPageArguments;
  final Widget Function(
    T object, {
    required void Function() onDelete,
    required void Function(T object) onSave,
    // required void Function() onEdit,
  }) cardBuilder;
  final List<T> list;
  final int index;
  final void Function(int oldIndex, int newIndex) onReorder;

  Character get char => controller.current!;

  @override
  Widget build(BuildContext context) {
    return CategorizedList(
      initiallyExpanded: true,
      title: Text(S.current.entityPlural(T)),
      itemPadding: const EdgeInsets.only(bottom: 8),
      trailing: [
        TextButton.icon(
          onPressed: () => Get.to(
            () => addPageBuilder(
              onAdd: (objects) => controller.updateCharacter(
                CharacterUtils.addByType<T>(char, objects),
              ),
            ),
            binding: AddRepositoryItemsBinding(),
            arguments: addPageArguments,
          ),
          label: Text(S.current.addGeneric(S.current.entityPlural(T))),
          icon: const Icon(Icons.add),
        ),
        GroupSortMenu(
            index: index, maxIndex: Character.allActionCategories.length, onReorder: onReorder)
      ],
      children: list
          .map(
            (obj) => Padding(
              key: Key('type-$T-' + keyFor<T>(obj)),
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: cardBuilder(
                obj,
                onDelete: _confirmDeleteDlg(context, obj, nameFor(obj)),
                onSave: (_obj) => controller.updateCharacter(
                  CharacterUtils.updateByType<T>(char, [_obj]),
                ),
              ),
            ),
          )
          .toList(),
      onReorder: (oldIndex, newIndex) =>
          controller.updateCharacter(CharacterUtils.reorderByType<T>(char, oldIndex, newIndex)),
    );
  }

  void Function() _confirmDeleteDlg(BuildContext context, T object, String name) {
    return () => awaitDeleteConfirmation<T>(
          context,
          name,
          () => controller.updateCharacter(
            CharacterUtils.removeByType<T>(char, [object]),
          ),
        );
  }
}
