import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'package:dungeon_paper/src/molecules/move_card.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';

class ReferenceView extends StatelessWidget {
  const ReferenceView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categories = <String, List>{
      'Basic Moves': dungeonWorld.basicMoves,
      'Special Moves': dungeonWorld.specialMoves,
    }..removeWhere((k, v) => v.isEmpty);

    return CategorizedList.builder(
      items: categories.keys,
      itemCount: (key, idx) => categories[key].length,
      titleBuilder: (ctx, key, idx) => Text(key),
      itemBuilder: (ctx, key, idx, catI) {
        var moves = categories[key];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: moves.first is Move
              ? MoveCard(
                  key: PageStorageKey('$key-$idx'),
                  move: moves[idx],
                  onSave: null,
                  onDelete: null,
                  mode: MoveCardMode.Fixed,
                )
              : Container(),
        );
      },
    );
  }
}
