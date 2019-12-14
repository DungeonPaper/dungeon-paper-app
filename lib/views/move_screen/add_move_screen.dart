import 'package:dungeon_world_data/player_class.dart';
import '../../components/dialogs.dart';
import 'add_move_list.dart';
import 'custom_move_form.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';

class AddMoveScreen extends StatefulWidget {
  const AddMoveScreen({
    Key key,
    @required this.move,
    @required this.mode,
    @required this.onSave,
    this.defaultClass,
  }) : super(key: key);

  final Move move;
  final DialogMode mode;
  final void Function(Move move) onSave;
  final PlayerClass defaultClass;

  @override
  AddMoveScreenState createState() => AddMoveScreenState();
}

class AddMoveScreenState extends State<AddMoveScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  AddMoveScreenState() {
    _controller = TabController(vsync: this, length: texts.length);
  }

  final List<String> texts = ['Class Moves', 'Custom Move'];
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
    return CustomMoveFormBuilder(
      mode: widget.mode,
      move: widget.move,
      onSave: widget.onSave,
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
              child: AddMoveList(
                key: PageStorageKey<String>(texts[0]),
                playerClass: widget.defaultClass,
                onSave: widget.onSave,
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
          actions: tabIdx == 1 || widget.mode == DialogMode.Edit ? actions : [],
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
