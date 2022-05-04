import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_repository_items_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/character_class_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'filters/character_class_filters.dart';

class AddCharacterClassesView
    extends GetView<AddRepositoryItemsController<CharacterClass, CharacterClassFilters>> {
  const AddCharacterClassesView({
    Key? key,
    required this.onChanged,
    required this.selection,
  }) : super(key: key);

  final void Function(CharacterClass characterClass) onChanged;
  final CharacterClass? selection;

  RepositoryService get service => controller.repo.value;
  Character get char => controller.chars.value.current!;

  @override
  Widget build(BuildContext context) {
    return AddRepositoryItemsView<CharacterClass, CharacterClassFilters>(
      storageKey: 'Classes',
      title: Text(S.current.addGeneric(S.current.entityPlural(CharacterClass))),
      multiple: false,
      filtersBuilder: (group, filters, onChange) => CharacterClassFiltersView(
        group: group,
        filters: filters,
        onChange: (f) => onChange(group, f),
        searchController: controller.search[group]!,
      ),
      filterFn: (characterClass, filters) => filters.filter(characterClass),
      cardBuilder: (
        ctx,
        characterClass, {
        required selected,
        required selectable,
        onToggle,
        onUpdate,
        onDelete,
        required label,
        required icon,
      }) =>
          CharacterClassCard(
        characterClass: characterClass,
        showDice: false,
        showStar: false,
        actions: [
          EntityEditMenu(
            onEdit: onUpdate != null
                ? CharacterUtils.openCharacterClassPage(
                    characterClass: characterClass,
                    onSave: onUpdate,
                  )
                : null,
            onDelete: onDelete != null ? () => onDelete(characterClass) : null,
          ),
          ElevatedButton.icon(
            style: ButtonThemes.primaryElevated(context),
            onPressed: onToggle,
            label: label,
            icon: icon,
          ),
        ],
      ),
      onAdd: (list) => onChanged(list.first),
      preSelections: selection != null ? [selection!] : [],
    );
  }
}
