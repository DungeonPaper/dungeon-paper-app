import 'package:dungeon_paper/components/categorized_list.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/notes.dart';
import 'package:dungeon_paper/notes_view/note_card.dart';
import 'package:flutter/material.dart';

class NotesView extends StatelessWidget {
  final DbCharacter character;

  NotesView({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<NoteCategory, Iterable<Note>> cats = {};
    NoteCategory.defaultCategories.forEach((category) {
      var notes = character.notes.where((note) => note.category == category);
      if (notes.isNotEmpty) {
        cats[category] = notes;
      }
    });

    return CategorizedList<NoteCategory>.builder(
      itemCount: (cat, idx) => cats[cat].length,
      categories: cats.keys,
      addSpacer: true,
      titleBuilder: (context, cat, idx) => Text(cat.name),
      itemBuilder: (context, cat, idx) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: NoteCard(
              key: Key(cats[cat].elementAt(idx).key),
              note: cats[cat].elementAt(idx),
            ),
          ),
    );
  }
}
