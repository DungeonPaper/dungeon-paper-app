import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/moves.dart';
import 'package:dungeon_paper/db/models/spells.dart';
import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'package:dungeon_paper/src/atoms/empty_state.dart';
import 'package:dungeon_paper/src/molecules/move_card.dart';
import 'package:dungeon_paper/src/molecules/spell_card.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';

enum CategoryKeys {
  StartingMoves,
  AdvancedMoves,
  Spells,
  EmptyState,
}

class BattleView extends StatelessWidget {
  static final _CATEGORY_LABELS = {
    CategoryKeys.StartingMoves: 'Starting Moves',
    CategoryKeys.AdvancedMoves: 'Advanced Moves',
    CategoryKeys.Spells: 'Spells',
    CategoryKeys.EmptyState: '',
  };

  final Character character;

  const BattleView({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categories = {
      CategoryKeys.StartingMoves:
          [character.race] + character.mainClass.startingMoves,
      CategoryKeys.AdvancedMoves: character.moves,
      CategoryKeys.Spells: character.spells,
    };
    if ([CategoryKeys.AdvancedMoves, CategoryKeys.Spells]
        .every((el) => categories[el].isEmpty)) {
      categories[CategoryKeys.EmptyState] = [null];
    }

    return CategorizedList.builder(
      items: categories.keys,
      itemCount: (key, idx) => categories[key].length,
      spacerCount: 1,
      titleBuilder: (ctx, key, idx) => Text(_CATEGORY_LABELS[key]),
      itemBuilder: (ctx, key, idx, catIdx) {
        var moves = categories[key];
        return buildItem(moves, idx, key);
      },
    );
  }

  Widget buildItem(List moves, num idx, CategoryKeys key) {
    if (key == CategoryKeys.EmptyState) {
      return EmptyState(
        assetName: 'armor.svg',
        title: Text('You have no learned skills'),
        subtitle: Text(
            "Add a move or spell using the '+' button to start building your list."),
      );
    }
    return moves?.isNotEmpty == true
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: moves[idx] is Move
                ? MoveCard(
                    key: PageStorageKey(moves[idx].key ?? moves[idx].name),
                    move: moves[idx],
                    mode: key == CategoryKeys.StartingMoves
                        ? MoveCardMode.Fixed
                        : MoveCardMode.Editable,
                    raceMove: key == CategoryKeys.StartingMoves && idx == 0,
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
          )
        : Container();
  }
}
