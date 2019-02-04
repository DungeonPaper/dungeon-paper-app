import 'package:dungeon_paper/db/notes.dart';
import 'package:flutter/material.dart';

class EditNoteDialog extends StatefulWidget {
  final num index;
  final String title;
  final String category;
  final String description;
  final void Function(Map note) onUpdateNote;

  EditNoteDialog({
    Key key,
    @required this.index,
    @required this.category,
    @required this.title,
    @required this.description,
    this.onUpdateNote,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditNoteDialogState(
      index: index, title: title, description: description, category: category, onUpdateNote: onUpdateNote);
}

class EditNoteDialogState extends State<EditNoteDialog> {
  final num index;
  String category;
  String title;
  String description;
  void Function(Map note) onUpdateNote;
  Map<String, TextEditingController> _controllers;

  EditNoteDialogState({
    Key key,
    @required this.index,
    @required this.category,
    @required this.title,
    @required this.description,
    this.onUpdateNote,
  })  : _controllers = {
          'title': TextEditingController(text: title.toString()),
          'description': TextEditingController(text: description.toString()),
          'category': TextEditingController(text: category.toString()),
        },
        super();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(16),
      title: Text('Edit Note'),
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      autocorrect: true,
                      onChanged: (val) => _setStateValue('title', val),
                      controller: _controllers['title'],
                      // style: TextStyle(fontSize: 13.0),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      autofocus: true,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      autocorrect: true,
                      onChanged: (val) => _setStateValue('description', val),
                      controller: _controllers['description'],
                      // style: TextStyle(fontSize: 13.0),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RaisedButton(
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () => _updateNote(),
                          child: const Text('Save'),
                        ),
                        RaisedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
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
          return category = newValue;
      }
    });
  }

  _updateNote() async {
    Map note = {
      'title': title,
      'description': description,
      'category': category
    };
    await updateNote(index, note);
    if (onUpdateNote != null) {
      onUpdateNote(note);
    }
    Navigator.pop(context);
  }
}
