import 'package:dungeon_paper/battle_view/edit_move_dialog.dart';
import 'package:dungeon_paper/components/card_bottom_controls.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MoveCard extends StatefulWidget {
  final num index;
  final Move move;
  final bool editable;

  const MoveCard({
    Key key,
    @required this.move,
    @required this.index,
    this.editable,
  }) : super(key: key);

  @override
  MoveCardState createState() => MoveCardState();
}

class MoveCardState extends State<MoveCard> {
  @override
  Widget build(BuildContext context) {
    Move move = widget.move;

    return Material(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: ExpansionTile(
        title: Text(move.name),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: MarkdownBody(data: move.description),
          ),
          CardBottomControls(
            onEdit: widget.editable
                ? () => EditMoveScreen(
                      index: widget.index,
                      move: widget.move,
                      mode: DialogMode.Edit,
                    )
                : null,
            onDelete: widget.editable ? () {} : null,
          ),
        ],
      ),
    );
  }
}
