import '../../components/markdown_help.dart';
import '../../db/moves.dart';
import '../../components/dialogs.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';

class CustomMoveFormBuilder extends StatefulWidget {
  final num index;
  final Move move;
  final DialogMode mode;
  final Widget Function(BuildContext context, Widget form, Function onSave)
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
  State<StatefulWidget> createState() => CustomMoveFormBuilderState();
}

class CustomMoveFormBuilderState extends State<CustomMoveFormBuilder> {
  String name;
  String description;
  String explanation;
  Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    _controllers = {
      'name': TextEditingController(text: (widget.move.name ?? '').toString()),
      'description': TextEditingController(
          text: (widget.move.description ?? '').toString()),
      'explanation': TextEditingController(
          text: (widget.move.explanation ?? '').toString()),
    };
    name = _controllers['name'].text;
    description = _controllers['description'].text;
    super.initState();
  }

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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Explanation'),
              autofocus: widget.mode == DialogMode.Edit,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (val) => _setStateValue('explanation', val),
              controller: _controllers['explanation'],
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
      widget.mode == DialogMode.Create ? _createMove : _updateMove,
    );
  }

  _setStateValue(String key, String newValue) {
    setState(() {
      switch (key) {
        case 'name':
          name = newValue;
          return;
        case 'description':
          description = newValue;
          return;
        case 'explanation':
          explanation = newValue;
          return;
      }
    });
  }

  _updateMove() async {
    var move = _generateMove();
    updateMove(move);
    if (widget.onUpdateMove != null) {
      widget.onUpdateMove(move);
    }
    Navigator.pop(context);
  }

  _createMove() async {
    var move = _generateMove();
    createMove(move);
    if (widget.onUpdateMove != null) {
      widget.onUpdateMove(move);
    }
    Navigator.pop(context);
  }

  Move _generateMove() {
    return Move(
      key: name.toLowerCase().replaceAll(RegExp('[^a-z]+'), '_'),
      name: name,
      description: description,
      explanation: explanation,
      classes: [],
    );
  }
}
