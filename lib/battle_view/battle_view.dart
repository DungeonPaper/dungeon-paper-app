import 'package:dungeon_paper/battle_view/move_card.dart';
import 'package:dungeon_paper/battle_view/spell_card.dart';
import 'package:dungeon_paper/components/categorized_list.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/spells.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';

class BattleView extends StatelessWidget {
  final DbCharacter character;

  const BattleView({Key key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, List> categories = {
      'Starting Moves': [character.race] + character.mainClass.startingMoves,
      'Advanced Moves': character.moves,
      'Spells': character.spells,
    }..removeWhere((k, v) => v.isEmpty);

    return CategorizedList.builder(
      categories: categories.keys,
      itemCount: (key, idx) => categories[key].length,
      addSpacer: true,
      titleBuilder: (ctx, key, idx) => Text(key),
      itemBuilder: (ctx, key, idx) {
        List moves = categories[key];
        MoveCardMode mode = key == 'Starting Moves'
            ? MoveCardMode.Fixed
            : MoveCardMode.Editable;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: moves.first is Move
              ? MoveCard(
                  key: PageStorageKey(moves[idx].key ?? moves[idx].name),
                  index: idx,
                  move: moves[idx],
                  mode: mode,
                  raceMove: key == 'Starting Moves' && idx == 0,
                )
              : moves.first is DbSpell
                  ? SpellCard(
                      index: idx,
                      spell: moves[idx],
                      mode: SpellCardMode.Editable,
                    )
                  : Container(),
        );
      },
    );
  }
}
