import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/widgets/cards/note_card.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/app/widgets/menus/group_sort_menu.dart';
import 'package:dungeon_paper/app/widgets/molecules/categorized_list.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class HomeCharacterJournalView extends StatelessWidget {
  const HomeCharacterJournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: PageStorageBucket(),
      child: CharacterProvider.consumer((context, controller, _) {
        if (controller.maybeCurrent == null) {
          return Container();
        }
        final char = controller.current;
        // return ReorderableListView(
        return ListView(
          // physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 70),
          // shrinkWrap: true,
          // onReorder: (oldIndex, newIndex) => controller.updateCharacter(
          //   char.copyWith(
          //     settings: char.settings.copyWith(
          //       noteCategoriesSort: Set.from(
          //         reorder(char.noteCategories.toList(), oldIndex, newIndex),
          //       ),
          //     ),
          //   ),
          // ),
          children: [
            for (final cat in enumerate(char.noteCategories))
              CategorizedList(
                key: Key('note-category-${cat.value}'),
                initiallyExpanded: true,
                title:
                    Text(cat.value.isEmpty ? tr.notes.noCategory : cat.value),
                titleTrailing: [
                  GroupSortMenu(
                    index: cat.index,
                    totalItemCount: char.noteCategories.length - 1,
                    onReorder: _move,
                  ),
                ],
                onReorder: (oldIndex, newIndex) => controller.updateCharacter(
                  CharacterUtils.reorderByType<Note>(char, oldIndex, newIndex,
                      extraData: cat.value),
                ),
                children: char.notes
                    .where((note) => note.localizedCategory == cat.value)
                    .map(
                      (note) => Padding(
                        key: Key('note-${note.key}'),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: NoteCard(
                          note: note,
                          reorderablePadding: true,
                          actions: [
                            EntityEditMenu(
                              onDelete: confirmDelete(
                                context,
                                note,
                                note.title,
                                tn(Note),
                              ),
                              onEdit: () => ModelPages.openNotePage(
                                note: note,
                                onSave: (note) {
                                  controller.updateCharacter(
                                    CharacterUtils.updateByType<Note>(
                                        char, [note]),
                                  );
                                  StorageHandler.instance
                                      .create('Notes', note.key, note.toJson());
                                },
                              ),
                            ),
                          ],
                          onSave: (note) => controller.updateCharacter(
                            CharacterUtils.updateNotes(char, [note]),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
          ],
        );
      }),
    );
  }

  void Function() confirmDelete<T>(
    BuildContext context,
    T object,
    String name,
    String typeName,
  ) {
    return () async {
      final controller = CharacterProvider.of(context);
      final char = controller.current;
      awaitDeleteConfirmation(context, name, () {
        controller.updateCharacter(
          char.copyWith(notes: removeByKey(char.notes, [object as Note])),
        );
      });
    };
  }

  Future<void> _move(BuildContext context, int oldIndex, int newIndex) {
    final controller = CharacterProvider.of(context);
    final char = controller.current;
    return controller.updateCharacter(
      char.copyWith(
        settings: char.settings.copyWith(
          noteCategories: char.settings.noteCategories.copyWithInherited(
            sortOrder: Set.from(
              reorder(
                char.noteCategories.toList(),
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
}

