import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_paper/move_screen/add_existing_move.dart';
import 'package:dungeon_paper/move_screen/add_spell.dart';
import 'package:dungeon_paper/move_screen/custom_move_form.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';

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

    return CustomMoveFormBuilder(
      mode: widget.mode,
      index: widget.index,
      name: widget.move.name,
      description: widget.move.description,
      builder: (ctx, form, onSave) {
        List<Widget> actions = tabIdx == 2 || widget.mode == DialogMode.Edit
            ? <Widget>[
                IconButton(
                  tooltip: 'Save',
                  icon: Icon(Icons.save),
                  onPressed: onSave,
                ),
              ]
            : [];
        var tabBarView = TabBarView(
          controller: _controller,
          children: <Widget>[
            Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: AddMove(
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
        );
        var formContainer = Container(
          key: PageStorageKey<String>(texts[1]),
          padding: EdgeInsets.all(16),
          child: form,
        );
        var tabBar = widget.mode == DialogMode.Create
            ? TabBar(
                controller: _controller,
                tabs: List.generate(
                  texts.length,
                  (i) => Tab(child: Text(texts[i])),
                ),
              )
            : null;
        List<Widget> children = <Widget>[
          AppBar(
            title: Text(
                '${widget.mode == DialogMode.Create ? 'Create' : 'Edit'} Move'),
            actions: actions,
          ),
          tabBar,
          Expanded(
            child:
                widget.mode == DialogMode.Create ? tabBarView : formContainer,
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
