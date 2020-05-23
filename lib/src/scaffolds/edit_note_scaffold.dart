import 'package:dungeon_paper/db/models/notes.dart';
import 'package:dungeon_paper/src/builders/note_form_builder.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    Key key,
    @required this.note,
    @required this.mode,
    @required this.onSave,
  }) : super(key: key);

  final Note note;
  final DialogMode mode;
  final void Function(Note) onSave;

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return NoteFormBuilder(
      mode: widget.mode,
      note: widget.note,
      onSave: widget.onSave,
      builder: (ctx, form, onSave) {
        return Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
            title: Text(
                '${widget.mode == DialogMode.Create ? 'Add' : 'Edit'} Note'),
            actions: <Widget>[
              IconButton(
                tooltip: 'Save',
                icon: Icon(Icons.save),
                onPressed: onSave,
              )
            ],
          ),
          body: Container(
            child: SingleChildScrollView(
              controller: scrollController,
              padding: EdgeInsets.all(16),
              child: form,
            ),
          ),
        );
      },
    );
  }
}