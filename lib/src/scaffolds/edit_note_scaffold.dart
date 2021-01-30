import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/notes.dart';
import 'package:dungeon_paper/src/builders/note_form_builder.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/scaffolds/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    Key key,
    @required this.note,
    @required this.mode,
    @required this.onSave,
    @required this.categories,
  }) : super(key: key);

  final Note note;
  final List<String> categories;
  final DialogMode mode;
  final void Function(Note) onSave;

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();

  factory EditNoteScreen.addForCharacter({@required Character character}) =>
      EditNoteScreen(
        note: Note(key: Uuid().v4()),
        mode: DialogMode.create,
        onSave: (note) => createNote(character, note),
        categories: collectCategories(character.notes),
      );
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return NoteFormBuilder(
      mode: widget.mode,
      note: widget.note,
      onSave: widget.onSave,
      categories: widget.categories,
      builder: (ctx, form, onSave) {
        return MainScaffold(
          title:
              Text('${widget.mode == DialogMode.create ? 'Add' : 'Edit'} Note'),
          actions: <Widget>[
            IconButton(
              tooltip: 'Save',
              icon: Icon(Icons.save),
              onPressed: onSave,
            )
          ],
          body: Padding(
            padding: EdgeInsets.all(16),
            child: form,
          ),
        );
      },
    );
  }
}
