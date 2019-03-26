import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_paper/move_screen/add_move.dart';
import 'package:dungeon_paper/move_screen/add_spell.dart';
import 'package:dungeon_paper/move_screen/custom_move_form.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';

class MoveScreen extends StatefulWidget {
  const MoveScreen({
    Key key,
    @required this.index,
    @required this.move,
    @required this.mode,
  }) : super(key: key);

  final num index;
  final Move move;
  final DialogMode mode;

  @override
  MoveScreenState createState() => MoveScreenState();
}

class MoveScreenState extends State<MoveScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  MoveScreenState() {
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
      move: widget.move,
      builder: (ctx, form, onSave) {
        List<Widget> actions = <Widget>[
          IconButton(
            tooltip: 'Save',
            icon: Icon(Icons.save),
            onPressed: onSave,
          ),
        ];
        var formContainer = Container(
          color: Theme.of(context).canvasColor,
          child: SingleChildScrollView(
            key: PageStorageKey<String>(texts[1]),
            padding: EdgeInsets.all(16),
            child: form,
          ),
        );
        var tabBarView = TabBarView(
          controller: _controller,
          children: <Widget>[
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: AddMove(
                key: PageStorageKey<String>(texts[0]),
                level: character.level,
                playerClass: character.mainClass,
              ),
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: AddSpell(
                key: PageStorageKey<String>(texts[1]),
              ),
            ),
            formContainer,
          ],
        );
        var tabBar = Container(
          color: Theme.of(context).canvasColor,
          child: TabBar(
            controller: _controller,
            tabs: List.generate(
              texts.length,
              (i) => Tab(child: Text(texts[i])),
            ),
          ),
        );
        var appBar = AppBar(
          title:
              Text('${widget.mode == DialogMode.Create ? 'Add' : 'Edit'} Move'),
          actions: tabIdx == 2 || widget.mode == DialogMode.Edit ? actions : [],
        );

        var list = <Widget>[
          Expanded(
            child:
                widget.mode == DialogMode.Create ? tabBarView : formContainer,
          ),
        ];
        if (widget.mode == DialogMode.Create) {
          list.insert(0, tabBar);
        }

        return Scaffold(
          appBar: appBar,
          body: Column(
            // mainAxisSize: MainAxisSize.max,
            children: list,
          ),
        );
      },
    );
  }
}
