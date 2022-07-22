import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/library_list_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/character_class_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'filters/character_class_filters.dart';

class CharacterClassesLibraryListView
    extends GetView<LibraryListController<CharacterClass, CharacterClassFilters>> {
  const CharacterClassesLibraryListView({
    Key? key,
  }) : super(key: key);

  RepositoryService get service => controller.repo.value;
  Character get char => controller.chars.value.current;

  @override
  Widget build(BuildContext context) {
    return LibraryListView<CharacterClass, CharacterClassFilters>(
      filtersBuilder: (group, filters, onChange) => CharacterClassFiltersView(
        group: group,
        filters: filters,
        onChange: (f) => onChange(group, f),
        searchController: controller.search[group]!,
      ),
      cardBuilder: (ctx, data) => CharacterClassCard(
        characterClass: data.item,
        showDice: false,
        showStar: false,
        highlightWords: data.highlightWords,
        actions: [
          EntityEditMenu(
            onEdit: data.onUpdate != null
                ? () => ModelPages.openCharacterClassPage(
                      characterClass: data.item,
                      onSave: data.onUpdate!,
                    )
                : null,
            onDelete: data.onDelete != null ? () => data.onDelete!(data.item) : null,
          ),
          if (data.selectable)
            ElevatedButton.icon(
              style: ButtonThemes.primaryElevated(context),
              onPressed: data.onToggle,
              label: data.label,
              icon: data.icon,
            ),
        ],
      ),
    );
  }
}

class CharacterClassLibraryListArguments
    extends LibraryListArguments<CharacterClass, CharacterClassFilters> {
  CharacterClassLibraryListArguments({
    required void Function(CharacterClass cls)? onAdd,
    required super.preSelections,
  }) : super(
          sortFn: CharacterClass.sorter,
          filterFn: (cls, filters) => filters.filter(cls),
          filters: {
            FiltersGroup.playbook: CharacterClassFilters(),
            FiltersGroup.my: CharacterClassFilters(),
          },
          onAdd: onAdd != null ? (cls) => onAdd.call(cls.first) : null,
          extraData: const {},
          multiple: false,
        );
}
