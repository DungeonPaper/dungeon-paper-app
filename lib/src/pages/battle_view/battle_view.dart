import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/moves.dart';
import 'package:dungeon_paper/db/models/spells.dart';
import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'package:dungeon_paper/src/molecules/move_card.dart';
import 'package:dungeon_paper/src/molecules/spell_card.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';

class BattleView extends StatelessWidget {
  final Character character;

  const BattleView({Key key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, List> categories = {
      'Starting Moves': [character.race] + character.mainClass.startingMoves,
      'Advanced Moves': character.moves,
      'Spells': character.spells,
    }..removeWhere((k, v) => v.isEmpty || v.every((_v) => _v == null));

    return CategorizedList.builder(
      items: categories.keys,
      itemCount: (key, idx) => categories[key].length,
      spacerCount: 1,
      titleBuilder: (ctx, key, idx) => Text(key),
      itemBuilder: (ctx, key, idx, catIdx) {
        List moves = categories[key];
        MoveCardMode mode = key == 'Starting Moves'
            ? MoveCardMode.Fixed
            : MoveCardMode.Editable;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: moves[idx] is Move
              ? MoveCard(
                  key: PageStorageKey(moves[idx].key ?? moves[idx].name),
                  move: moves[idx],
                  mode: mode,
                  raceMove: key == 'Starting Moves' && idx == 0,
                  onSave: (move) => updateMove(character, move),
                  onDelete: () => deleteMove(character, moves[idx]),
                )
              : SpellCard(
                  index: idx,
                  spell: moves[idx],
                  mode: SpellCardMode.Editable,
                  onSave: (spell) => updateSpell(character, spell),
                  onDelete: () => deleteSpell(character, moves[idx]),
                ),
        );
      },
    );
  }
}
