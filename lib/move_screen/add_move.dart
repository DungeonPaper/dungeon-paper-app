import 'package:dungeon_paper/battle_view/move_card.dart';
import 'package:dungeon_paper/components/categorized_list.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class AddMove extends StatelessWidget {
  final PlayerClass playerClass;
  final num level;
  AddMove({Key key, @required this.playerClass, @required this.level});

  @override
  Widget build(BuildContext context) {
    Map<int, List<Move>> moves = {
      1: playerClass.advancedMoves1,
      6: playerClass.advancedMoves2
    };

    return CategorizedList.builder(
      categories: moves.keys,
      titleBuilder: (ctx, minLevel, idx) =>
          Text("Levels $minLevel-${minLevel + 4}"),
      itemBuilder: (ctx, key, idx) => Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: MoveCard(
              index: -1,
              move: moves[key].elementAt(idx),
              mode: MoveCardMode.Addable,
            ),
          ),
      itemCount: (key, idx) => moves[key].length,
      addSpacer: true,
    );
  }
}
