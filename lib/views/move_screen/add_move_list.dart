import '../battle_view/move_card.dart';
import '../../components/categorized_list.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class AddMoveList extends StatefulWidget {
  final PlayerClass playerClass;
  final num level;
  final void Function(Move move) onSave;

  AddMoveList({
    Key key,
    @required this.playerClass,
    @required this.level,
    @required this.onSave,
  });

  @override
  _AddMoveListState createState() => _AddMoveListState();
}

class _AddMoveListState extends State<AddMoveList> {
  PlayerClass currentCls;

  @override
  void initState() {
    currentCls = widget.playerClass;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, List<Move>> moves = {
      1: currentCls.advancedMoves1,
      6: currentCls.advancedMoves2
    };
    const LEADING_KEY = '';

    return CategorizedList.builder(
      items: [LEADING_KEY] + moves.keys.map((k) => k.toString()).toList(),
      titleBuilder: (ctx, minLevel, idx) => minLevel != LEADING_KEY
          ? Text("Levels $minLevel-${int.parse(minLevel) + 4}")
          : null,
      itemBuilder: (ctx, key, idx, catI) {
        if (key == LEADING_KEY) {
          return Row(
            children: <Widget>[
              Expanded(
                child: Text('Moves from class:'),
              ),
              Expanded(
                child: DropdownButton(
                  isExpanded: true,
                  value: currentCls,
                  onChanged: (cls) => setState(() {
                    currentCls = cls;
                  }),
                  items: dungeonWorld.classes
                      .map((v) => DropdownMenuItem(
                            value: v,
                            child: Text(v.name),
                          ))
                      .toList(),
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
            index: -1,
            move: moves[int.parse(key)].elementAt(idx),
            mode: MoveCardMode.Addable,
            onSave: widget.onSave,
          ),
        );
      },
      itemCount: (key, idx) =>
          key != LEADING_KEY ? moves[int.parse(key)].length : 1,
      spacerCount: 1,
    );
  }
}
