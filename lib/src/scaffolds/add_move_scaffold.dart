import 'package:dungeon_paper/src/builders/custom_move_form_builder.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/lists/add_move_list.dart';
import 'package:dungeon_paper/src/scaffolds/main_scaffold.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        var actions = <Widget>[
          IconButton(
            tooltip: 'Save',
            icon: Icon(Icons.save),
            onPressed: onSave,
          ),
        ];
        var formContainer = Container(
          color: Get.theme.scaffoldBackgroundColor,
          child: SingleChildScrollView(
            key: PageStorageKey<String>(texts[1]),
            padding: EdgeInsets.all(16),
            child: form,
          ),
        );
        var tabBarView = TabBarView(
          controller: _controller,
          children: <Widget>[
            AddMoveList(
              key: PageStorageKey<String>(texts[0]),
              playerClass: widget.defaultClass,
              onSave: widget.onSave,
            ),
            formContainer,
          ],
        );
        var tabBar = TabBar(
          controller: _controller,
          tabs: List.generate(
            texts.length,
            (i) => Tab(child: Text(texts[i])),
          ),
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

        return MainScaffold(
          useElevation: false,
          wrapWithScrollable: false,
          elevation: 0.0,
          title:
              Text('${widget.mode == DialogMode.Create ? 'Add' : 'Edit'} Move'),
          actions: tabIdx == 1 || widget.mode == DialogMode.Edit ? actions : [],
          body: Column(
            children: list,
          ),
        );
      },
    );
  }
}
