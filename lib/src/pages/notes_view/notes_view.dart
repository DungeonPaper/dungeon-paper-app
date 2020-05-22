import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/notes.dart';
import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'note_card.dart';
import 'package:flutter/material.dart';

class NotesView extends StatelessWidget {
  final Character character;

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
      items: cats.keys,
      spacerCount: 1,
      titleBuilder: (context, cat, idx) => Text(cat.name),
      itemBuilder: (context, cat, idx, catI) {
        var note = cats[cat].elementAt(idx);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: NoteCard(
            key: Key(note.key),
            note: note,
            onSave: (_note) => updateNote(character, _note),
            onDelete: () => deleteNote(character, note),
          ),
        );
      },
    );
  }
}
