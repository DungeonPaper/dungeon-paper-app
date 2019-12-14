import '../../components/dialogs.dart';
import 'custom_move_form.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';

class AddRaceMoveScreen extends StatefulWidget {
  const AddRaceMoveScreen({
    Key key,
    @required this.move,
    @required this.mode,
    @required this.onSave,
  }) : super(key: key);

  final Move move;
  final DialogMode mode;
  final void Function(Move move) onSave;

  @override
  AddRaceMoveScreenState createState() => AddRaceMoveScreenState();
}

class AddRaceMoveScreenState extends State<AddRaceMoveScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  AddRaceMoveScreenState() {
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
      moveLabel: 'Race',
      builder: (ctx, form, onSave) {
        var appBar = AppBar(
          title: Text(
              '${widget.mode == DialogMode.Create ? 'Add' : 'Edit'} Race Move'),
          actions: <Widget>[
            IconButton(
              tooltip: 'Save',
              icon: Icon(Icons.save),
              onPressed: onSave,
            ),
          ],
        );

        return Scaffold(
          appBar: appBar,
          body: SingleChildScrollView(
            child: Container(
              color: Theme.of(context).canvasColor,
              child: SingleChildScrollView(
                key: PageStorageKey<String>(texts[1]),
                padding: EdgeInsets.all(16),
                child: form,
              ),
            ),
          ),
        );
      },
    );
  }
}
