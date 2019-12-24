import 'package:dungeon_paper/components/categorized_list.dart';
import 'package:dungeon_paper/components/dialogs.dart';
import 'package:dungeon_paper/views/battle_view/move_card.dart';
import 'package:dungeon_paper/views/move_screen/add_move_screen.dart';
import 'package:dungeon_paper/views/move_screen/add_race_move_screen.dart';
import 'package:dungeon_paper/widget_utils.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../flutter_utils.dart';

enum MoveCategory { Race, Starting, Advanced1, Advanced2 }

class CustomClassMoveList extends StatelessWidget {
  final VoidCallbackDelegate<PlayerClass> onUpdate;
  final PlayerClass playerClass;
  final DialogMode mode;
  final ValueNotifier validityNotifier;

  const CustomClassMoveList({
    Key key,
    @required this.onUpdate,
    @required this.playerClass,
    @required this.mode,
    this.validityNotifier,
  }) : super(key: key);

  static const TITLES = {
    MoveCategory.Race: 'Races',
    MoveCategory.Starting: 'Starting Moves',
    MoveCategory.Advanced1: 'Advanced Moves 1-5',
    MoveCategory.Advanced2: 'Advanced Moves 6-10',
  };

  @override
  Widget build(BuildContext context) {
    Map<MoveCategory, List<Move>> cats = {
      MoveCategory.Race: playerClass.raceMoves,
      MoveCategory.Starting: playerClass.startingMoves,
      MoveCategory.Advanced1: playerClass.advancedMoves1,
      MoveCategory.Advanced2: playerClass.advancedMoves2,
    };

    return CategorizedList.builder(
      items: cats.values,
      itemCount: (moves, i) => moves != null ? moves.length + 1 : 1,
      titleBuilder: (context, moves, i) => Text(
          i < cats.keys.length ? TITLES[cats.keys.elementAt(i)] : 'No Title'),
      itemBuilder: (context, List<Move> moves, i, catI) {
        MoveCategory cat = cats.keys.elementAt(catI);

        if (i >= moves.length) {
          return Center(
            child: AddButton(
              onPressed: () => _addMove(context, cat),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: MoveCard(
            move: moves[i],
            raceMove: cats.keys.elementAt(catI) == MoveCategory.Race,
            mode: MoveCardMode.Editable,
            onSave: (move) => _updateMoveInCat(context, move, cat),
          ),
        );
      },
    );
  }

  _addMove(BuildContext context, MoveCategory cat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          Move blankMove = Move(
            key: Uuid().v4(),
            name: '',
            description: '',
            explanation: '',
            classes: [],
          );
          if (cat == MoveCategory.Race) {
            return AddRaceMoveScreen(
              mode: DialogMode.Create,
              move: blankMove,
              onSave: (move) => _addMoveToCat(context, move, cat),
            );
          }
          return AddMoveScreen(
            mode: DialogMode.Create,
            move: blankMove,
            onSave: (move) => _addMoveToCat(context, move, cat),
          );
        },
      ),
    );
  }

  _addMoveToCat(BuildContext context, Move move, MoveCategory cat) {
    switch (cat) {
      case MoveCategory.Starting:
        playerClass.startingMoves.add(move);
        break;
      case MoveCategory.Race:
        playerClass.raceMoves.add(move);
        break;
      case MoveCategory.Advanced1:
        playerClass.advancedMoves1.add(move);
        break;
      case MoveCategory.Advanced2:
        playerClass.advancedMoves2.add(move);
        break;
    }

    if (onUpdate != null) onUpdate(playerClass);
    Navigator.pop(context);
  }

  _updateMoveInCat(BuildContext context, Move move, MoveCategory cat) {
    switch (cat) {
      case MoveCategory.Starting:
        num idx =
            playerClass.startingMoves.indexWhere((m) => m.key == move.key);
        playerClass.startingMoves[idx] = move;
        break;
      case MoveCategory.Race:
        num idx = playerClass.raceMoves.indexWhere((m) => m.key == move.key);
        playerClass.raceMoves[idx] = move;
        break;
      case MoveCategory.Advanced1:
        num idx =
            playerClass.advancedMoves1.indexWhere((m) => m.key == move.key);
        playerClass.advancedMoves1[idx] = move;
        break;
      case MoveCategory.Advanced2:
        num idx =
            playerClass.advancedMoves2.indexWhere((m) => m.key == move.key);
        playerClass.advancedMoves2[idx] = move;
        break;
    }

    if (onUpdate != null) onUpdate(playerClass);
    Navigator.pop(context);
  }
}
