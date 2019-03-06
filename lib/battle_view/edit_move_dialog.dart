import 'package:dungeon_paper/db/moves.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';

class EditMoveFormState extends State<EditMoveForm> {
  final num index;
  final DialogMode mode;
  String name;
  String description;
  void Function(Move move) onUpdateMove;
  Widget Function(BuildContext context, Widget form, Function onSave) builder;
  Map<String, TextEditingController> _controllers;

  EditMoveFormState({
    Key key,
    @required this.index,
    @required this.name,
    @required this.description,
    @required this.mode,
    @required this.builder,
    this.onUpdateMove,
  })  : _controllers = {
          'name': TextEditingController(text: (name ?? '').toString()),
          'description': TextEditingController(text: (description ?? '').toString()),
        },
        super();

  @override
  Widget build(BuildContext context) {
    Widget form = Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: 'Move Name'),
            autofocus: mode == DialogMode.Create,
            autocorrect: true,
            textCapitalization: TextCapitalization.words,
            onChanged: (val) => _setStateValue('name', val),
            controller: _controllers['name'],
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
      mode == DialogMode.Create ? _createMove : _updateMove,
    );
  }

  _setStateValue(String key, String newValue) {
    setState(() {
      switch (key) {
        case 'name':
          return name = newValue;
        case 'description':
          return description = newValue;
      }
    });
  }

  _updateMove() async {
    Move move = Move(name: name, description: description, classes: []);
    updateMove(index, move);
    if (onUpdateMove != null) {
      onUpdateMove(move);
    }
    Navigator.pop(context);
  }

  _createMove() async {
    Move move = Move(name: name, description: description, classes: []);
    createMove(move);
    if (onUpdateMove != null) {
      onUpdateMove(move);
    }
    Navigator.pop(context);
  }
}

class EditMoveForm extends StatefulWidget {
  final num index;
  final String name;
  final String description;
  final DialogMode mode;
  final void Function(BuildContext context, Widget form, Function onSave)
      builder;
  final void Function(Move move) onUpdateMove;

  EditMoveForm({
    Key key,
    @required this.index,
    @required this.name,
    @required this.description,
    @required this.mode,
    @required this.builder,
    this.onUpdateMove,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditMoveFormState(
        index: index,
        name: name,
        description: description,
        onUpdateMove: onUpdateMove,
        mode: mode,
        builder: builder,
      );
}

class EditMoveDialog extends StatelessWidget {
  const EditMoveDialog({
    Key key,
    @required this.index,
    @required this.move,
    @required this.mode,
  }) : super(key: key);

  final num index;
  final Move move;
  final DialogMode mode;

  @override
  Widget build(BuildContext context) {
    return EditMoveForm(
      mode: mode,
      index: index,
      name: move.name,
      description: move.description,
      builder: (ctx, form, onSave) => SimpleDialog(
            contentPadding: EdgeInsets.all(16),
            title:
                Text('${mode == DialogMode.Create ? 'Create' : 'Edit'} Move'),
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

class EditMoveScreen extends StatelessWidget {
  const EditMoveScreen({
    Key key,
    @required this.index,
    @required this.move,
    @required this.mode,
  }) : super(key: key);

  final num index;
  final Move move;
  final DialogMode mode;

  @override
  Widget build(BuildContext context) {
    return EditMoveForm(
      mode: mode,
      index: index,
      name: move.name,
      description: move.description,
      builder: (ctx, form, onSave) => Material(
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Text(
                      '${mode == DialogMode.Create ? 'Create' : 'Edit'} Move'),
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
