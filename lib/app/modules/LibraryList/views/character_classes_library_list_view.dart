import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/library_list_view.dart';
import 'package:dungeon_paper/app/widgets/cards/character_class_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'filters/character_class_filters.dart';
import 'library_select_button.dart';

class CharacterClassesLibraryListView extends StatelessWidget {
  const CharacterClassesLibraryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<
        LibraryListController<CharacterClass, CharacterClassFilters>>(
      builder: (context, controller, _) =>
          LibraryListView<CharacterClass, CharacterClassFilters>(
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
          trailing: [
            if (controller.selectable)
              LibrarySelectButton<CharacterClass>.icon(
                selected: data.selected,
                onPressed: data.onToggle,
              )
          ],
          actions: [
            EntityEditMenu(
              onEdit: data.onUpdate != null
                  ? () => ModelPages.openCharacterClassPage(
                        context,
                        characterClass: data.item,
                        onSave: data.onUpdate!,
                      )
                  : null,
              onDelete: data.onDelete != null
                  ? () => data.onDelete!(data.item)
                  : null,
            ),
            if (controller.selectable)
              LibrarySelectButton<CharacterClass>(
                selected: data.selected,
                onPressed: data.onToggle,
              )
          ],
        ),
      ),
    );
  }
}

class CharacterClassLibraryListArguments
    extends LibraryListArguments<CharacterClass, CharacterClassFilters> {
  CharacterClassLibraryListArguments({
    required void Function(CharacterClass cls)? onSelected,
    required super.preSelections,
    super.initialTab,
  }) : super(
          sortFn: CharacterClass.sorter,
          filterFn: (cls, filters) => filters.filter(cls),
          filters: {
            FiltersGroup.playbook: CharacterClassFilters(),
            FiltersGroup.my: CharacterClassFilters(),
          },
          onSelected:
              onSelected != null ? (cls) => onSelected.call(cls.first) : null,
          extraData: const {},
          multiple: false,
        );
}
