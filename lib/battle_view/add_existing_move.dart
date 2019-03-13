import 'package:dungeon_paper/battle_view/move_card.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class AddExistingMove extends StatelessWidget {
  final PlayerClass playerClass;
  final num level;
  AddExistingMove({Key key, @required this.playerClass, @required this.level});

  @override
  Widget build(BuildContext context) {
    Map<int, List<Move>> moves = {
      1: playerClass.advancedMoves1,
      6: playerClass.advancedMoves2
    };
    Iterable<Widget> movesByLevel =
        moves.keys.where((minLevel) => level >= minLevel).map((minLevel) {
      List moveSet = moves[minLevel];
      Widget title = Text("Levels $minLevel-${minLevel + 4}",
          style: TextStyle(color: Theme.of(context).textTheme.subtitle.color));
      return Container(
        padding: EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title] +
              moveSet
                  .map(
                    (move) => Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: MoveCard(
                            index: -1,
                            move: move,
                            mode: MoveCardMode.Addable,
                          ),
                        ),
                  )
                  .toList(),
        ),
      );
    });
    return ListView(
      padding: EdgeInsets.all(16),
      children: movesByLevel.toList(),
    );
  }
}
