import 'package:dungeon_paper/db/notes.dart';
import 'package:flutter/material.dart';

enum DialogMode { Edit, Create }

class EditNoteFormState extends State<EditNoteForm> {
  final num index;
  final DialogMode mode;
  NoteCategory category;
  String title;
  String description;
  void Function(Note note) onUpdateNote;
  Widget Function(BuildContext context, Widget form, Function onSave) builder;
  Map<String, TextEditingController> _controllers;

  EditNoteFormState({
    Key key,
    @required this.index,
    @required this.category,
    @required this.title,
    @required this.description,
    @required this.mode,
    @required this.builder,
    this.onUpdateNote,
  })  : _controllers = {
          'title': TextEditingController(text: title.toString()),
          'description': TextEditingController(text: description.toString()),
          'category': TextEditingController(text: category.toString()),
        },
        super();

  @override
  Widget build(BuildContext context) {
    Widget form = Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DropdownButton(
            hint: Text('Category'),
            value: category,
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
            autofocus: mode == DialogMode.Create,
            autocorrect: true,
            textCapitalization: TextCapitalization.words,
            onChanged: (val) => _setStateValue('title', val),
            controller: _controllers['title'],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Description'),
              autofocus: mode == DialogMode.Edit,
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
        ],
      ),
    );

    return builder(
      context,
      form,
      mode == DialogMode.Create ? _createNote : _updateNote,
    );
  }

  _setStateValue(String key, String newValue) {
    setState(() {
      switch (key) {
        case 'title':
          return title = newValue;
        case 'description':
          return description = newValue;
        case 'category':
          return category = NoteCategory(newValue);
      }
    });
  }

  _updateNote() async {
    Note note = Note(
        {'title': title, 'description': description, 'category': category});
    updateNote(index, note);
    if (onUpdateNote != null) {
      onUpdateNote(note);
    }
    Navigator.pop(context);
  }

  _createNote() async {
    Note note = Note(
        {'title': title, 'description': description, 'category': category});
    createNote(note);
    if (onUpdateNote != null) {
      onUpdateNote(note);
    }
    Navigator.pop(context);
  }
}

class EditNoteForm extends StatefulWidget {
  final num index;
  final String title;
  final NoteCategory category;
  final String description;
  final DialogMode mode;
  final void Function(BuildContext context, Widget form, Function onSave) builder;
  final void Function(Note note) onUpdateNote;

  EditNoteForm({
    Key key,
    @required this.index,
    @required this.category,
    @required this.title,
    @required this.description,
    @required this.mode,
    @required this.builder,
    this.onUpdateNote,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditNoteFormState(
        index: index,
        title: title,
        description: description,
        category: category,
        onUpdateNote: onUpdateNote,
        mode: mode,
        builder: builder,
      );
}

class EditNoteDialog extends StatelessWidget {
  const EditNoteDialog({
    Key key,
    @required this.index,
    @required this.note,
    @required this.mode,
  }) : super(key: key);

  final num index;
  final Note note;
  final DialogMode mode;

  @override
  Widget build(BuildContext context) {
    return EditNoteForm(
      mode: DialogMode.Edit,
      index: index,
      title: note.title,
      description: note.description,
      category: note.category,
      builder: (ctx, form, onSave) => SimpleDialog(
            contentPadding: EdgeInsets.all(16),
            title:
                Text('${mode == DialogMode.Create ? 'Create' : 'Edit'} Note'),
            children: <Widget>[
              form,
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    RaisedButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: onSave,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}

class EditNoteScreen extends StatelessWidget {
  const EditNoteScreen({
    Key key,
    @required this.index,
    @required this.note,
    @required this.mode,
  }) : super(key: key);

  final num index;
  final Note note;
  final DialogMode mode;

  @override
  Widget build(BuildContext context) {
    return EditNoteForm(
      mode: DialogMode.Edit,
      index: index,
      title: note.title,
      description: note.description,
      category: note.category,
      builder: (ctx, form, onSave) => Material(
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Text(
                      '${mode == DialogMode.Create ? 'Create' : 'Edit'} Note'),
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
