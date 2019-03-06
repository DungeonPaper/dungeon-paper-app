import 'package:dungeon_paper/battle_view/move_card.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BattleView extends StatelessWidget {
  final DbCharacter character;
  static const TextStyle titleStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  const BattleView({Key key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> cats = [];
    Map<String, List<Move>> categories = {
      'Starting Moves': character.mainClass.startingMoves,
      'Advanced Moves': character.moves
    };
    num i = 0;
    categories.forEach((cat, moves) {
      cats.add(
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Text(cat, style: titleStyle)] +
                moves
                    .map((move) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: MoveCard(
                            index: i,
                            move: move,
                            editable: cat == 'Advanced Moves',
                          ),
                        ))
                    .toList(),
          ),
        ),
      );
      i++;
    });
    return OrientationBuilder(builder: (context, orientation) {
      return StaggeredGridView.countBuilder(
        crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
        itemCount: cats.length,
        itemBuilder: (context, index) => cats[index],
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      );
    });
  }
}
