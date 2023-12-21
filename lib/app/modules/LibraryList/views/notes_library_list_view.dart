import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/library_list_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/note_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'filters/note_filters.dart';

class NotesLibraryListView extends StatelessWidget
    with RepositoryProviderMixin {
  const NotesLibraryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryListController<Note, NoteFilters>>(
      builder: (context, controller, _) => LibraryListView<Note, NoteFilters>(
        filtersBuilder: (group, filters, onChange) => NoteFiltersView(
          filters: filters,
          onChange: (f) => onChange(group, f),
          searchController: controller.search[group]!,
        ),
        cardBuilder: (ctx, data) => NoteCard(
          note: data.item,
          showStar: false,
          highlightWords: data.highlightWords,
          actions: [
            EntityEditMenu(
              onEdit: data.onUpdate != null
                  ? () => ModelPages.openNotePage(
                        context,
                        note: data.item,
                        onSave: data.onUpdate!,
                      )
                  : null,
              onDelete: data.onDelete != null
                  ? () => data.onDelete!(data.item)
                  : null,
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
      ),
    );
  }
}

class NoteLibraryListArguments extends LibraryListArguments<Note, NoteFilters> {
  NoteLibraryListArguments({
    required super.onSelected,
    required super.preSelections,
    super.initialTab,
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
