import 'package:dungeon_paper/components/markdown_help.dart';
import 'package:dungeon_paper/db/moves.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';

class CustomMoveFormBuilder extends StatefulWidget {
  final num index;
  final Move move;
  final DialogMode mode;
  final void Function(BuildContext context, Widget form, Function onSave)
      builder;
  final void Function(Move move) onUpdateMove;

  CustomMoveFormBuilder({
    Key key,
    @required this.index,
    @required this.move,
    @required this.mode,
    @required this.builder,
    this.onUpdateMove,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomMoveFormBuilderState(
        index: index,
        name: move.name,
        description: move.description,
        onUpdateMove: onUpdateMove,
        mode: mode,
        builder: builder,
      );
}
class CustomMoveFormBuilderState extends State<CustomMoveFormBuilder> {
  final num index;
  final DialogMode mode;
  String name;
  String description;
  void Function(Move move) onUpdateMove;
  Widget Function(BuildContext context, Widget form, Function onSave) builder;
  Map<String, TextEditingController> _controllers;

  CustomMoveFormBuilderState({
    Key key,
    @required this.index,
    @required this.name,
    @required this.description,
    @required this.mode,
    @required this.builder,
    this.onUpdateMove,
  })  : _controllers = {
          'name': TextEditingController(text: (name ?? '').toString()),
          'description':
              TextEditingController(text: (description ?? '').toString()),
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
          MarkdownHelp(),
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
    Move move = Move(
      key: name.toLowerCase().replaceAll(RegExp('[^a-z]+'), '_'),
      name: name,
      description: description,
      classes: [],
    );
    updateMove(move);
    if (onUpdateMove != null) {
      onUpdateMove(move);
    }
    Navigator.pop(context);
  }

  _createMove() async {
    Move move = Move(
      key: name.toLowerCase().replaceAll(RegExp('[^a-z]+'), '_'),
      name: name,
      description: description,
      classes: [],
    );
    createMove(move);
    if (onUpdateMove != null) {
      onUpdateMove(move);
    }
    Navigator.pop(context);
  }
}
