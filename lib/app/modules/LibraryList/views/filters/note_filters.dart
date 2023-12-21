import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/entity_filters.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';

class NoteFiltersView extends StatelessWidget {
  const NoteFiltersView({
    super.key,
    required this.filters,
    required this.onChange,
    required this.searchController,
  });

  final NoteFilters filters;
  final void Function(NoteFilters) onChange;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return EntityFiltersView<Note, NoteFilters>(
      filters: filters,
      emptyFilters: NoteFilters(),
      onChange: onChange,
      searchController: searchController,
      typeName: tn(Note),
    );
  }
}

class NoteFilters extends EntityFilters<Note> {
  String? search;

  NoteFilters({
    this.search,
  });

  @override
  bool filter(Note note) {
    if (search != null && search!.isNotEmpty) {
      if (![
        note.title,
        note.description,
        ...note.tags.map((t) => t.name),
        ...note.tags.map((t) => t.value?.toString()),
      ].any((el) => cleanStr(el ?? '').contains(cleanStr(search!)))) {
        return false;
      }
    }
    return true;
  }

  @override
  void setSearch(String search) => this.search = search;

  @override
  List<bool?> get filterActiveList => [];

  @override
  double getScore(Note note) {
    return avg(
      [note.title, note.description].map(
        (e) => (search?.isEmpty ?? true) || e.isEmpty
            ? 0.0
            : StringSimilarity.compareTwoStrings(search!, e),
      ),
    );
  }
}
