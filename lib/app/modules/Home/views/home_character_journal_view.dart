import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/note_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/app/widgets/menus/group_sort_menu.dart';
import 'package:dungeon_paper/app/widgets/molecules/categorized_list.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeCharacterJournalView extends GetView<CharacterService> {
  const HomeCharacterJournalView({Key? key}) : super(key: key);

  Character get char => controller.current;

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: PageStorageBucket(),
      child: Obx(() {
        if (controller.maybeCurrent == null) {
          return Container();
        }
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
                key: Key('note-category-' + cat.value),
                initiallyExpanded: true,
                title: Text(cat.value.isEmpty ? S.current.noteNoCategory : cat.value),
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
                        key: Key('note-' + note.key),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: NoteCard(
                          note: note,
                          actions: [
                            EntityEditMenu(
                              onDelete: confirmDelete(context, note, note.title),
                              onEdit: () => ModelPages.openNotePage(
                                note: note,
                                onSave: (_note) {
                                  controller.updateCharacter(
                                    CharacterUtils.updateByType<Note>(char, [_note]),
                                  );
                                  StorageHandler.instance.create('Notes', note.key, note.toJson());
                                },
                              ),
                            ),
                          ],
                          onSave: (_note) => controller.updateCharacter(
                            CharacterUtils.updateNotes(char, [_note]),
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

  void Function() confirmDelete<T>(BuildContext context, T object, String name) {
    return () async {
      final result = await Get.dialog<bool>(
        AlertDialog(
          title: Text(S.current.confirmDeleteTitle(S.current.entity(T))),
          content: Text(S.current.confirmDeleteBody(S.current.entity(T), name)),
          actions: [
            ElevatedButton.icon(
              icon: const Icon(Icons.close),
              label: Text(S.current.cancel),
              onPressed: () => Get.back(result: false),
              style: ButtonThemes.primaryElevated(context),
            ),
            // const SizedBox(width: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.delete),
              label: Text(S.current.remove),
              onPressed: () => Get.back(result: true),
              style: ButtonThemes.errorElevated(context),
            ),
            const SizedBox(width: 0),
          ],
        ),
      );

      if (result == true) {
        switch (T) {
          case Note:
            controller.updateCharacter(
              char.copyWith(notes: removeByKey(char.notes, [object as Note])),
            );
            break;
          case Spell:
            controller.updateCharacter(
              char.copyWith(spells: removeByKey(char.spells, [object as Spell])),
            );
            break;
          case Item:
            controller.updateCharacter(
              char.copyWith(items: removeByKey(char.items, [object as Item])),
            );
            break;
          default:
            throw TypeError();
        }
      }
    };
  }

  Future<void> _move(int oldIndex, int newIndex) {
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
