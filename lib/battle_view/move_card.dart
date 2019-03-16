import 'package:dungeon_paper/components/card_bottom_controls.dart';
import 'package:dungeon_paper/components/confirmation_dialog.dart';
import 'package:dungeon_paper/db/moves.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_paper/move_screen/move_screen.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

enum MoveCardMode { Addable, Editable, Fixed }

class MoveCard extends StatefulWidget {
  final num index;
  final Move move;
  final MoveCardMode mode;

  const MoveCard({
    Key key,
    @required this.move,
    @required this.index,
    this.mode,
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
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: ExpansionTile(
        title: Text(move.name),
        initiallyExpanded: false,
        children: <Widget>[
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
                          builder: (ctx) => MoveScreen(
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
        ],
      ),
    );
  }
}
