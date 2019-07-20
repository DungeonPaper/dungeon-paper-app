import 'package:dungeon_paper/components/card_bottom_controls.dart';
import 'package:dungeon_paper/components/confirmation_dialog.dart';
import 'package:dungeon_paper/db/moves.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_paper/move_screen/add_move_screen.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

enum MoveCardMode { Addable, Editable, Fixed }

class MoveCard extends StatefulWidget {
  final num index;
  final Move move;
  final MoveCardMode mode;
  final bool raceMove;

  const MoveCard({
    Key key,
    @required this.move,
    @required this.index,
    this.raceMove = false,
    this.mode,
  }) : super(key: key);

  @override
  MoveCardState createState() => MoveCardState();
}

class MoveCardState extends State<MoveCard> {
  @override
  Widget build(BuildContext context) {
    Move move = widget.move;
    Widget name =
        Text("${move.name}${widget.raceMove ? '\'s Racial Move' : ''}");

    var children = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: MarkdownBody(data: move.description),
      ),
      widget.mode == MoveCardMode.Editable
          ? CardBottomControls(
              onEdit: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (ctx) => AddMoveScreen(
                            index: widget.index,
                            move: widget.move,
                            mode: DialogMode.Edit,
                          ),
                    ),
                  ),
              onDelete: () async => await showDialog(
                    context: context,
                    builder: (ctx) => ConfirmationDialog(
                          title: Text('Delete Move?'),
                          okButtonText: Text('Delete Move'),
                        ),
                  )
                      ? deleteMove(widget.move)
                      : null,
            )
          : widget.mode == MoveCardMode.Addable
              ? Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorLight,
                      child: Text('Add Move'),
                      onPressed: () {
                        createMove(widget.move);
                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                )
              : SizedBox.shrink(),
    ];

    if (widget.move.explanation != null && widget.move.explanation.isNotEmpty) {
      children.insertAll(1, [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child:
                Text('Explanation', style: Theme.of(context).textTheme.body2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: MarkdownBody(data: move.explanation),
        ),
      ]);
    }
    var expansionTile = ExpansionTile(
      title: widget.raceMove
          ? Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.pets, size: 12.0),
                ),
                Expanded(child: name),
              ],
            )
          : name,
      initiallyExpanded: false,
      children: children,
    );
    return Material(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: expansionTile,
    );
  }
}
