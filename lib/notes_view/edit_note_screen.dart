import 'package:dungeon_paper/components/markdown_help.dart';
import 'package:dungeon_paper/db/notes.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:flutter/material.dart';

class EditNoteForm extends StatefulWidget {
  final Note note;
  final DialogMode mode;
  final Widget Function(BuildContext context, Widget form, Function onSave)
      builder;
  final void Function(Note note) onUpdateNote;

  EditNoteForm({
    Key key,
    @required this.note,
    @required this.mode,
    @required this.builder,
    this.onUpdateNote,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditNoteFormState();
}

class EditNoteFormState extends State<EditNoteForm> {
  Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    _controllers = {
      'title': TextEditingController(text: widget.note.title.toString()),
      'description':
          TextEditingController(text: widget.note.description.toString()),
      'category': TextEditingController(text: widget.note.category.toString()),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget form = Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DropdownButton(
            hint: Text('Category'),
            value: widget.note.category,
            onChanged: (cat) => _setStateValue('category', cat.toString()),
            items: NoteCategory.defaultCategories
                .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.toString()),
                    ))
                .toList(),
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Title'),
            autofocus: widget.mode == DialogMode.Create,
            autocorrect: true,
            textCapitalization: TextCapitalization.words,
            onChanged: (val) => _setStateValue('title', val),
            controller: _controllers['title'],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Description'),
              autofocus: widget.mode == DialogMode.Edit,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (val) => _setStateValue('description', val),
              controller: _controllers['description'],
              // style: TextStyle(fontSize: 13.0),
              // textAlign: TextAlign.center,
            ),
          ),
          MarkdownHelp(),
        ],
      ),
    );

    return widget.builder(
      context,
      form,
      widget.mode == DialogMode.Create ? _createNote : _updateNote,
    );
  }

  _setStateValue(String key, String newValue) {
    setState(() {
      switch (key) {
        case 'title':
          return widget.note.title = newValue;
        case 'description':
          return widget.note.description = newValue;
        case 'category':
          return widget.note.category = NoteCategory(newValue);
      }
    });
  }

  _updateNote() async {
    updateNote(widget.note);
    if (widget.onUpdateNote != null) {
      widget.onUpdateNote(widget.note);
    }
    Navigator.pop(context);
  }

  _createNote() async {
    createNote(widget.note);
    if (widget.onUpdateNote != null) {
      widget.onUpdateNote(widget.note);
    }
    Navigator.pop(context);
  }
}

class EditNoteScreen extends StatelessWidget {
  const EditNoteScreen({
    Key key,
    @required this.note,
    @required this.mode,
  }) : super(key: key);

  final Note note;
  final DialogMode mode;

  @override
  Widget build(BuildContext context) {
    return EditNoteForm(
      mode: mode,
      note: note,
      builder: (ctx, form, onSave) => Material(
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Text(
                      '${mode == DialogMode.Create ? 'Add' : 'Edit'} Note'),
                  actions: <Widget>[
                    IconButton(
                      tooltip: 'Save',
                      icon: Icon(Icons.save),
                      onPressed: onSave,
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: form,
                ),
              ],
            ),
          ),
    );
  }
}
