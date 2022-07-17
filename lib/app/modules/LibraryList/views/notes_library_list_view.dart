import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/library_list_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/note_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'filters/note_filters.dart';

class NotesLibraryListView extends GetView<LibraryListController<Note, NoteFilters>> {
  const NotesLibraryListView({
    Key? key,
  }) : super(key: key);

  RepositoryService get service => controller.repo.value;
  Character get character => controller.chars.value.current;

  @override
  Widget build(BuildContext context) {
    return LibraryListView<Note, NoteFilters>(
      title: Text(S.current.addGeneric(S.current.entityPlural(Note))),
      filtersBuilder: (group, filters, onChange) => NoteFiltersView(
        filters: filters,
        onChange: (f) => onChange(group, f),
        searchController: controller.search[group]!,
      ),
      cardBuilder: (
        ctx,
        note, {
        required selected,
        required selectable,
        onToggle,
        onUpdate,
        onDelete,
        required label,
        required icon,
      }) =>
          NoteCard(
        note: note,
        showStar: false,
        actions: [
          EntityEditMenu(
            onEdit: onUpdate != null
                ? () => ModelPages.openNotePage(
                      note: note,
                      onSave: onUpdate,
                    )
                : null,
            onDelete: onDelete != null ? () => onDelete(note) : null,
          ),
          if (selectable)
            ElevatedButton.icon(
              style: ButtonThemes.primaryElevated(context),
              onPressed: onToggle,
              label: label,
              icon: icon,
            ),
        ],
      ),
    );
  }
}

class NoteLibraryListArguments extends LibraryListArguments<Note, NoteFilters> {
  NoteLibraryListArguments({
    required super.onAdd,
    required super.preSelections,
  }) : super(
          sortFn: (f) => (a, b) => 0,
          filterFn: (note, filters) => filters.filter(note),
          filters: {
            FiltersGroup.playbook: NoteFilters(),
            FiltersGroup.my: NoteFilters(),
          },
          extraData: const {},
        );
}
