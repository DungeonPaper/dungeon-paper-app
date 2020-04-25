import 'package:dungeon_paper/components/dialogs.dart';
import 'package:dungeon_paper/components/markdown_help.dart';
import 'package:dungeon_paper/db/notes.dart';
import 'package:flutter/material.dart';

class EditNoteForm extends StatefulWidget {
  final Note note;
  final DialogMode mode;
  final Widget Function(BuildContext context, Widget form, Function() onSave)
      builder;
  final void Function(Note note) onSave;

  EditNoteForm({
    Key key,
    @required this.note,
    @required this.mode,
    @required this.builder,
    this.onSave,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditNoteFormState();
}

class EditNoteFormState extends State<EditNoteForm> {
  Map<String, TextEditingController> _controllers;
  String title;
  String description;
  NoteCategory category;

  @override
  void initState() {
    _controllers = {
      'title': TextEditingController(text: widget.note.title ?? ''),
      'description': TextEditingController(text: widget.note.description ?? ''),
    };
    title = _controllers['title'].text;
    description = _controllers['description'].text;
    category = widget.note.category ?? NoteCategory.misc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget form = Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DropdownButton<NoteCategory>(
            hint: Text('Category'),
            value: category,
            onChanged: (cat) => _setStateValue('category', cat),
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

  _setStateValue(String key, dynamic newValue) {
    setState(() {
      switch (key) {
        case 'title':
          title = newValue.toString();
          return;
        case 'description':
          description = newValue.toString();
          return;
        case 'category':
          category = newValue as NoteCategory;
          return;
      }
    });
  }

  _updateNote() async {
    var note = _generateNote();
    if (widget.onSave != null) {
      widget.onSave(note);
    }
    Navigator.pop(context);
  }

  _createNote() async {
    var note = _generateNote();
    if (widget.onSave != null) {
      widget.onSave(note);
    }
    Navigator.pop(context);
  }

  Note _generateNote() {
    return Note({
      'key': widget.note.key,
      'title': _controllers['title'].text,
      'description': _controllers['description'].text,
      'category': category,
    });
  }
}

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
    return EditNoteForm(
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
