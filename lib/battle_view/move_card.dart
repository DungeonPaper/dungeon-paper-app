import 'package:dungeon_paper/components/card_bottom_controls.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MoveCard extends StatefulWidget {
  final Move move;

  const MoveCard({Key key, this.move}) : super(key: key);

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
            onEdit: () {},
            onDelete: () {},
          ),
        ],
      ),
    );
  }
}
