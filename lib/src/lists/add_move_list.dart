import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'package:dungeon_paper/src/lists/player_class_list.dart';
import 'package:dungeon_paper/src/molecules/move_card.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class AddMoveList extends StatefulWidget {
  final PlayerClass playerClass;
  final void Function(Move move) onSave;

  AddMoveList({
    Key key,
    this.playerClass,
    @required this.onSave,
  });

  @override
  _AddMoveListState createState() => _AddMoveListState();
}

class _AddMoveListState extends State<AddMoveList> {
  PlayerClass currentCls;

  @override
  void initState() {
    currentCls = widget.playerClass ?? dungeonWorld.classes.elementAt(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var moves = <int, List<Move>>{
      0: currentCls.startingMoves,
      2: currentCls.advancedMoves1,
      6: currentCls.advancedMoves2
    };
    const LEADING_KEY = '';

    return CategorizedList.builder(
      items: [LEADING_KEY] + moves.keys.map((k) => k.toString()).toList(),
      titleBuilder: (ctx, String minLevel, idx) {
        if (minLevel == LEADING_KEY) {
          return null;
        }

        var maxLevel = moves.keys.firstWhere(
                (curLevel) => curLevel > int.tryParse(minLevel),
                orElse: () => 11) -
            1;

        return minLevel == '0'
            ? Text('Starting Moves')
            : Text('Levels $minLevel-${maxLevel}');
      },
      itemBuilder: (ctx, key, idx, catI) {
        if (key == LEADING_KEY) {
          return Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Moves from class:',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              Expanded(
                child: PlayerClassList.dropdown(
                  value: currentCls,
                  onChanged: (cls) {
                    setState(() {
                      currentCls = cls;
                    });
                  },
                ),
              )
            ],
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: MoveCard(
            move: moves[int.parse(key)].elementAt(idx),
            mode: MoveCardMode.Addable,
            onSave: widget.onSave,
            onDelete: null,
          ),
        );
      },
      itemCount: (key, idx) =>
          key != LEADING_KEY ? moves[int.parse(key)].length : 1,
      spacerCount: 1,
    );
  }
}
