import 'package:dungeon_paper/battle_view/add_existing_move.dart';
import 'package:dungeon_paper/battle_view/add_spell.dart';
import 'package:dungeon_paper/components/markdown_help.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/moves.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
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
    updateMove(index, move);
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

class EditMoveScreen extends StatefulWidget {
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
  EditMoveScreenState createState() => EditMoveScreenState();
}

class EditMoveScreenState extends State<EditMoveScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  EditMoveScreenState() {
    _controller = TabController(vsync: this, length: texts.length);
  }

  final List<String> texts = ['Class Moves', 'Spells', 'Custom Move'];
  int tabIdx = 0;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        tabIdx = _controller.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DbCharacter character = dwStore.state.characters.current;

    return EditMoveForm(
      mode: widget.mode,
      index: widget.index,
      name: widget.move.name,
      description: widget.move.description,
      builder: (ctx, form, onSave) {
        var children = <Widget>[
          AppBar(
            title: Text(
                '${widget.mode == DialogMode.Create ? 'Create' : 'Edit'} Move'),
            actions: tabIdx == 2 || widget.mode == DialogMode.Edit
                ? <Widget>[
                    IconButton(
                      tooltip: 'Save',
                      icon: Icon(Icons.save),
                      onPressed: onSave,
                    ),
                  ]
                : [],
          ),
          widget.mode == DialogMode.Create
              ? TabBar(
                  controller: _controller,
                  tabs: List.generate(
                    texts.length,
                    (i) => Tab(child: Text(texts[i])),
                  ),
                )
              : null,
          Expanded(
            child: widget.mode == DialogMode.Create
                ? TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      Material(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: AddExistingMove(
                          key: PageStorageKey<String>(texts[0]),
                          level: character.level,
                          playerClass: character.mainClass,
                        ),
                      ),
                      Material(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: AddSpell(
                          key: PageStorageKey<String>(texts[1]),
                        ),
                      ),
                      Container(
                        key: PageStorageKey<String>(texts[2]),
                        padding: EdgeInsets.all(16),
                        child: form,
                      ),
                    ],
                  )
                : Container(
                    key: PageStorageKey<String>(texts[1]),
                    padding: EdgeInsets.all(16),
                    child: form,
                  ),
          ),
        ].where((el) => el != null).toList();

        return Material(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: children,
          ),
        );
      },
    );
  }
}
