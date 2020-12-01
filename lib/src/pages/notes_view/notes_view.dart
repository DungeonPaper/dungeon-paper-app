import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/notes.dart';
import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'package:dungeon_paper/src/atoms/empty_state.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
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
    var cats = groupBy<String, Note>(character.notes, (note) => note.category);
    if (cats.values.every((el) => el.isEmpty)) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: EmptyState(
          title: Text('You have no notes'),
          subtitle: Text("Add notes for your campaign using the '+' button"),
          image: Icon(Icons.speaker_notes, size: 80),
        ),
      );
    }

    return CategorizedList<String>.builder(
      keyBuilder: (ctx, key, idx) => 'NotesView.' + enumName(key),
      itemCount: (cat, idx) => cats[cat].length,
      items: cats.keys,
      bottomSpacerHeight: BOTTOM_SPACER.height,
      titleBuilder: (context, cat, idx) => Text(cat),
      itemBuilder: (context, cat, idx, catI) {
        var note = cats[cat].elementAt(idx);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: NoteCard(
            key: PageStorageKey(note.key),
            note: note,
            categories: collectCategories(character.notes),
            onSave: (_note) => updateNote(character, _note),
            onDelete: () => deleteNote(character, note),
          ),
        );
      },
    );
  }
}
