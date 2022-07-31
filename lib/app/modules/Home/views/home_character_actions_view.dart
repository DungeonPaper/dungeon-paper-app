import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_settings.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/library_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/items_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/moves_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/spells_library_list_view.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/checklist_menu_entry.dart';
import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
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
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'local_widgets/home_character_actions_summary.dart';

class HomeCharacterActionsView extends GetView<CharacterService> {
  const HomeCharacterActionsView({Key? key}) : super(key: key);

  Character get char => controller.current;

  @override
  Widget build(BuildContext context) {
    final builder = ItemBuilder.builder(
      leadingBuilder: (context, index) => const HomeCharacterActionsSummary(),
      leadingCount: 1,
      itemBuilder: (context, index) {
        switch (char.actionCategories.elementAt(index)) {
          case Move:
            return movesList ?? const SizedBox.shrink();
          case Spell:
            return spellsList ?? const SizedBox.shrink();
          case Item:
            return itemsList ?? const SizedBox.shrink();
        }

        return const SizedBox.shrink();
      },
      itemCount: char.actionCategories.length,
    );
    return PageStorage(
      bucket: PageStorageBucket(),
      child: Obx(
        () {
          if (controller.maybeCurrent == null) {
            return Container();
          }
          return builder.asListView(
            padding: const EdgeInsets.only(bottom: 16),
          );
        },
      ),
    );
  }

  Widget? get movesList {
    if (char.settings.actionCategories.hidden.contains(Move)) {
      return null;
    }
    final raceCard = RaceCard(
      race: char.race,
      onSave: (race) => controller.updateCharacter(
        char.copyWithInherited(race: race),
      ),
      actions: [
        EntityEditMenu(
          onDelete: null,
          onEdit: () => ModelPages.openRacePage(
            race: char.race,
            abilityScores: char.abilityScores,
            onSave: (race) => controller.updateCharacter(
              char.copyWithInherited(race: race),
            ),
          ),
        ),
      ],
    );
    return ActionsCardList<Move>(
      index: char.actionCategories.toList().indexOf(Move),
      onReorder: _onReorder,
      list: char.moves,
      route: Routes.moves,
      leading: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: Text(
                  S.current.actionsBasicMoves,
                ),
                onPressed: _openBasicMoves,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                child: Text(
                  S.current.actionsSpecialMoves,
                ),
                onPressed: _openSpecialMoves,
              ),
            ),
          ],
        ),
        const SizedBox(height: 0),
        const Divider(height: 1),
        const SizedBox(height: 4),
        if (char.settings.racePosition == RacePosition.start) raceCard,
      ],
      trailing: char.settings.racePosition == RacePosition.end ? [raceCard] : [],
      menuTrailing: [
        if (char.settings.racePosition != RacePosition.start)
          // Move to start of list
          MenuEntry(
            value: 'move_to_start',
            label: Text(S.current.moveToStartGeneric(S.current.entity(Race))),
            onSelect: () => controller.updateCharacter(
              char.copyWith(
                settings: char.settings.copyWith(racePosition: RacePosition.start),
              ),
            ),
          ),
        if (char.settings.racePosition != RacePosition.end)
          // Move to end of list
          MenuEntry(
            value: 'move_to_end',
            label: Text(S.current.moveToEndGeneric(S.current.entity(Race))),
            onSelect: () => controller.updateCharacter(
              char.copyWith(
                settings: char.settings.copyWith(racePosition: RacePosition.end),
              ),
            ),
          ),
      ],
      addPageArguments: ({required onAdd}) => MoveLibraryListArguments(
        character: char,
        onAdd: onAdd,
        preSelections: char.moves,
      ),
      cardBuilder: (move, {required onSave, required onDelete}) => MoveCard(
        move: move,
        advancedLevelDisplay: AdvancedLevelDisplay.none,
        abilityScores: char.abilityScores,
        actions: [
          EntityEditMenu(
            onDelete: onDelete,
            onEdit: () => ModelPages.openMovePage(
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

  Widget? get spellsList {
    if (char.settings.actionCategories.hidden.contains(Spell)) {
      return null;
    }
    return ActionsCardList<Spell>(
      index: char.actionCategories.toList().indexOf(Spell),
      onReorder: _onReorder,
      list: char.spells,
      route: Routes.spells,
      addPageArguments: ({required onAdd}) => SpellLibraryListArguments(
        character: char,
        onAdd: onAdd,
        preSelections: char.spells,
      ),
      cardBuilder: (spell, {required onSave, required onDelete}) => SpellCard(
        spell: spell,
        abilityScores: char.abilityScores,
        actions: [
          EntityEditMenu(
            onDelete: onDelete,
            onEdit: () => ModelPages.openSpellPage(
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

  Widget? get itemsList {
    if (char.settings.actionCategories.hidden.contains(Item)) {
      return null;
    }
    return ActionsCardList<Item>(
      index: char.actionCategories.toList().indexOf(Item),
      onReorder: _onReorder,
      list: char.items,
      route: Routes.items,
      addPageArguments: ({required onAdd}) => ItemLibraryListArguments(
        onAdd: (items) => onAdd(
          items
              .map(
                (x) => x.copyWithInherited(amount: x.amount == 0 ? 1 : x.amount),
              )
              .toList(),
        ),
        preSelections: char.items,
      ),
      cardBuilder: (item, {required onSave, required onDelete}) => ItemCard(
        item: item,
        actions: [
          EntityEditMenu(
            onDelete: onDelete,
            onEdit: () => ModelPages.openItemPage(
              item: item,
              onSave: onSave(true),
            ),
            leading: [
              ChecklistMenuEntry(
                value: 'countArmor',
                checked: item.settings.countArmor,
                label: Text(S.current.itemSettingsCountArmor),
                onChanged: (value) => onSave(false)(
                  item.copyWithInherited(
                    settings: item.settings.copyWith(countArmor: value!),
                  ),
                ),
              ),
              ChecklistMenuEntry(
                value: 'countDamage',
                checked: item.settings.countDamage,
                label: Text(S.current.itemSettingsCountDamage),
                onChanged: (value) => onSave(false)(
                  item.copyWithInherited(
                    settings: item.settings.copyWith(countDamage: value!),
                  ),
                ),
              ),
              ChecklistMenuEntry(
                value: 'countWeight',
                checked: item.settings.countWeight,
                label: Text(S.current.itemSettingsCountWeight),
                onChanged: (value) => onSave(false)(
                  item.copyWithInherited(
                    settings: item.settings.copyWith(countWeight: value!),
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

  void _onReorder(int oldIndex, int newIndex) {
    controller.updateCharacter(
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

  void _openBasicMoves() {
    ModelPages.openMovesList(
      category: MoveCategory.basic,
      initialTab: FiltersGroup.playbook,
      abilityScores: char.abilityScores,
    );
  }

  void _openSpecialMoves() {
    ModelPages.openMovesList(
      category: MoveCategory.special,
      initialTab: FiltersGroup.playbook,
      abilityScores: char.abilityScores,
    );
  }
}

class ActionsCardList<T extends WithMeta> extends GetView<CharacterService>
    with LibraryServiceMixin, RepositoryServiceMixin {
  const ActionsCardList({
    Key? key,
    required this.route,
    required this.addPageArguments,
    required this.cardBuilder,
    required this.list,
    required this.index,
    required this.onReorder,
    this.menuLeading = const [],
    this.menuTrailing = const [],
    this.leading = const [],
    this.trailing = const [],
  }) : super(key: key);

  final String route;
  final List<Widget> leading;
  final List<Widget> trailing;
  final LibraryListArguments<T, EntityFilters<T>> Function({
    required void Function(Iterable<T> obj) onAdd,
  }) addPageArguments;
  final Widget Function(
    T object, {
    required void Function() onDelete,
    required void Function(T object) Function(bool fork) onSave,
    // required void Function() onEdit,
  }) cardBuilder;
  final List<T> list;
  final int index;
  final void Function(int oldIndex, int newIndex) onReorder;
  final List<MenuEntry<String>> menuLeading;
  final List<MenuEntry<String>> menuTrailing;

  Character get char => controller.current;

  @override
  Widget build(BuildContext context) {
    return CategorizedList(
      initiallyExpanded: true,
      title: Text(S.current.entityPlural(T)),
      itemPadding: const EdgeInsets.only(bottom: 8),
      titleTrailing: [
        TextButton.icon(
          onPressed: () => Get.toNamed(
            route,
            arguments: addPageArguments(
              onAdd: (items) => library.upsertToCharacter(items, forkBehavior: ForkBehavior.fork),
            ),
          ),
          label: Text(S.current.addGeneric(S.current.entityPlural(T))),
          icon: const Icon(Icons.add),
        ),
        GroupSortMenu(
          index: index,
          totalItemCount: Character.allActionCategories.length,
          onReorder: onReorder,
          leading: menuLeading,
          trailing: menuTrailing,
        )
      ],
      leading: leading.map((obj) => _wrapChild(child: obj)).toList(),
      trailing: trailing.map((obj) => _wrapChild(child: obj)).toList(),
      children: [
        ...list.map(
          (obj) => _wrapChild(
            key: PageStorageKey('type-$T-' + obj.key),
            child: cardBuilder(
              obj,
              onDelete: _confirmDeleteDlg(context, obj, obj.displayName),
              onSave: (fork) => (_obj) {
                library.upsertToCharacter([_obj], forkBehavior: ForkBehavior.none);
              },
            ),
          ),
        ),
      ],
      onReorder: (oldIndex, newIndex) =>
          controller.updateCharacter(CharacterUtils.reorderByType<T>(char, oldIndex, newIndex)),
    );
  }

  Widget _wrapChild({Key? key, required Widget child}) => Padding(
        key: key,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: child,
      );

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
