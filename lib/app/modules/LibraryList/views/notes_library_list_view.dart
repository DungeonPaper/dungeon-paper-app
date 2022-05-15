import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
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
    required this.onAdd,
    required this.selections,
    required this.classKeys,
    required this.abilityScores,
  }) : super(key: key);

  final void Function(Iterable<Note> notes) onAdd;
  final Iterable<Note> selections;
  final List<String> classKeys;
  final AbilityScores abilityScores;

  RepositoryService get service => controller.repo.value;
  Character get char => controller.chars.value.current!;

  @override
  Widget build(BuildContext context) {
    return LibraryListView<Note, NoteFilters>(
      storageKey: 'Notes',
      title: Text(S.current.addGeneric(S.current.entityPlural(Note))),
      filtersBuilder: (group, filters, onChange) => NoteFiltersView(
        filters: filters,
        onChange: (f) => onChange(group, f),
        searchController: controller.search[group]!,
      ),
      filterFn: (notes, filters) => filters.filter(notes),
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
                ? CharacterUtils.openNotePage(
                    note: note,
                    onSave: onUpdate,
                  )
                : null,
            onDelete: onDelete != null ? () => onDelete(note) : null,
          ),
          ElevatedButton.icon(
            style: ButtonThemes.primaryElevated(context),
            onPressed: onToggle,
            label: label,
            icon: icon,
          ),
        ],
      ),
      onAdd: onAdd,
      preSelections: selections,
    );
  }
}
