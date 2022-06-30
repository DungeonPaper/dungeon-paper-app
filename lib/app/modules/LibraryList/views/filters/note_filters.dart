import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/entity_filters.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:string_similarity/string_similarity.dart';

class NoteFiltersView extends StatelessWidget {
  NoteFiltersView({
    Key? key,
    required this.filters,
    required this.onChange,
    required this.searchController,
  }) : super(key: key);

  final NoteFilters filters;
  final service = Get.find<RepositoryService>();
  final void Function(NoteFilters) onChange;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return EntityFiltersView<Note, NoteFilters>(
      filters: filters,
      emptyFilters: NoteFilters(),
      onChange: onChange,
      searchController: searchController,
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
        ...note.tags.map((t) => t.value),
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
