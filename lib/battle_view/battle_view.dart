import 'package:dungeon_paper/battle_view/move_card.dart';
import 'package:dungeon_paper/battle_view/spell_card.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/main_view/main_view.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/spell.dart';
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
    Map<String, List> categories = {
      'Starting Moves': character.mainClass.startingMoves,
      'Advanced Moves': character.moves,
      'Spells': character.spells,
    };
    categories.forEach((cat, moves) {
      MoveCardMode mode =
          cat == 'Starting Moves' ? MoveCardMode.Fixed : MoveCardMode.Editable;
      if (moves != null && moves.isNotEmpty) {
        cats.add(
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Text(cat, style: titleStyle)] +
                  List.generate(
                    moves.length,
                    (i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: moves.first is Move
                              ? MoveCard(
                                  index: i,
                                  move: moves[i],
                                  mode: mode,
                                )
                              : moves.first is Spell
                                  ? SpellCard(
                                      index: i,
                                      spell: moves[i],
                                      mode: SpellCardMode.Editable,
                                    )
                                  : Container(),
                        ),
                  ),
            ),
          ),
        );
      }
    });
    return Container(child: OrientationBuilder(builder: (context, orientation) {
      return StaggeredGridView.countBuilder(
        crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
        itemCount: cats.length + 1,
        itemBuilder: (context, index) =>
            index < cats.length ? cats[index] : MainView.bottomSpacer,
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      );
    }));
  }
}
