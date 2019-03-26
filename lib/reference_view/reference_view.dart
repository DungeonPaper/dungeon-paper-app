import 'package:dungeon_paper/battle_view/move_card.dart';
import 'package:dungeon_paper/battle_view/spell_card.dart';
import 'package:dungeon_paper/components/categorized_list.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/spell.dart';
import 'package:flutter/material.dart';

class ReferenceView extends StatelessWidget {
  const ReferenceView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, List> categories = {
      'Basic Moves': dungeonWorld.basicMoves,
      'Special Moves': dungeonWorld.specialMoves,
    }..removeWhere((k, v) => v.isEmpty);

    return CategorizedList.builder(
      categories: categories.keys,
      itemCount: (key, idx) => categories[key].length,
      titleBuilder: (ctx, key, idx) => Text(key),
      itemBuilder: (ctx, key, idx) {
        List moves = categories[key];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: moves.first is Move
              ? MoveCard(
                  key: PageStorageKey('$key-$idx'),
                  index: idx,
                  move: moves[idx],
                  mode: MoveCardMode.Fixed,
                )
              : moves.first is Spell
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
