import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/atoms/flexible_columns.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/molecules/move_card.dart';
import 'package:dungeon_paper/src/scaffolds/add_move_scaffold.dart';
import 'package:dungeon_paper/src/scaffolds/add_race_move_scaffold.dart';
import 'package:dungeon_paper/src/utils/types.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

enum MoveCategory { Race, Starting, Advanced1, Advanced2 }

class CustomClassMoveList extends StatelessWidget {
  final VoidCallbackDelegate<CustomClass> onUpdate;
  final CustomClass customClass;
  final DialogMode mode;
  final ValueNotifier validityNotifier;
  final bool raceMoveMode;

  const CustomClassMoveList({
    Key key,
    @required this.onUpdate,
    @required this.customClass,
    @required this.mode,
    this.validityNotifier,
    @required this.raceMoveMode,
  }) : super(key: key);

  static const TITLES = {
    MoveCategory.Race: 'Races',
    MoveCategory.Starting: 'Starting Moves',
    MoveCategory.Advanced1: 'Advanced Moves 2-5',
    MoveCategory.Advanced2: 'Advanced Moves 6-10',
  };

  @override
  Widget build(BuildContext context) {
    final cats = <MoveCategory, List<Move>>{
      if (raceMoveMode) MoveCategory.Race: customClass.raceMoves,
      if (!raceMoveMode) ...{
        MoveCategory.Starting: customClass.startingMoves,
        MoveCategory.Advanced1: customClass.advancedMoves1,
        MoveCategory.Advanced2: customClass.advancedMoves2,
      }
    };

    return FlexibleColumns.builder(
      keyBuilder: null,
      items: cats.values,
      itemCount: (moves, i) => moves != null ? moves.length + 1 : 1,
      titleBuilder: (context, moves, i) => raceMoveMode == true
          ? null
          : Text(
              i < cats.keys.length
                  ? TITLES[cats.keys.elementAt(i)]
                  : 'No Title',
            ),
      itemBuilder: (context, List<Move> moves, i, catI) {
        final cat = cats.keys.elementAt(catI);

        if (i >= moves.length) {
          return Center(
            child: Column(
              children: [
                if (raceMoveMode)
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      for (final race in [
                        _RaceTemplate('Human'),
                        _RaceTemplate('Elf'),
                        _RaceTemplate('Orc'),
                        _RaceTemplate('Dwarf'),
                        _RaceTemplate('Halfling'),
                      ])
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: RaisedButton(
                            color: Get.theme.cardColor,
                            child: Text('Add ${race.name}'),
                            onPressed: customClass.raceMoves.firstWhere(
                                        (m) => m.name == race.name,
                                        orElse: () => null) ==
                                    null
                                ? _onAddTemplate(name: race.name)
                                : null,
                          ),
                        ),
                    ],
                  ),
                AddButton(
                  backgroundColor: Get.theme.colorScheme.surface,
                  foregroundColor: Get.theme.colorScheme.onSurface,
                  onPressed: () => _addMove(context, cat),
                ),
              ],
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
              onDelete: () => _deleteMoveInCat(context, moves[i], cat)),
        );
      },
    );
  }

  void _addMove(BuildContext context, MoveCategory cat) {
    final blankMove = Move(
      key: Uuid().v4(),
      name: '',
      description: '',
      explanation: '',
      classes: [],
    );
    Get.to(
      cat == MoveCategory.Race
          ? AddRaceMoveScaffold(
              mode: DialogMode.Create,
              move: blankMove,
              onSave: (move) => _addMoveToCat(context, move, cat),
            )
          : AddMoveScreen(
              mode: DialogMode.Create,
              move: blankMove,
              onSave: (move) => _addMoveToCat(context, move, cat),
            ),
    );
  }

  void _addMoveToCat(BuildContext context, Move move, MoveCategory cat) {
    switch (cat) {
      case MoveCategory.Starting:
        customClass.startingMoves.add(move);
        customClass.fields['startingMoves'].setDirty(true);
        break;
      case MoveCategory.Race:
        customClass.raceMoves.add(move);
        customClass.fields['raceMoves'].setDirty(true);
        break;
      case MoveCategory.Advanced1:
        customClass.advancedMoves1.add(move);
        customClass.fields['advancedMoves1'].setDirty(true);
        break;
      case MoveCategory.Advanced2:
        customClass.advancedMoves2.add(move);
        customClass.fields['advancedMoves2'].setDirty(true);
        break;
    }
    _update();
    Get.back();
  }

  void _updateMoveInCat(BuildContext context, Move move, MoveCategory cat) {
    switch (cat) {
      case MoveCategory.Race:
        num idx = customClass.raceMoves.indexWhere((m) => m.key == move.key);
        customClass.raceMoves[idx] = move;
        customClass.fields['raceMoves'].setDirty(true);
        break;
      case MoveCategory.Starting:
        num idx =
            customClass.startingMoves.indexWhere((m) => m.key == move.key);
        customClass.startingMoves[idx] = move;
        customClass.fields['startingMoves'].setDirty(true);
        break;
      case MoveCategory.Advanced1:
        num idx =
            customClass.advancedMoves1.indexWhere((m) => m.key == move.key);
        customClass.advancedMoves1[idx] = move;
        customClass.fields['advancedMoves1'].setDirty(true);
        break;
      case MoveCategory.Advanced2:
        num idx =
            customClass.advancedMoves2.indexWhere((m) => m.key == move.key);
        customClass.advancedMoves2[idx] = move;
        customClass.fields['advancedMoves2'].setDirty(true);
        break;
    }

    _update();
  }

  void _deleteMoveInCat(BuildContext context, Move move, MoveCategory cat) {
    switch (cat) {
      case MoveCategory.Race:
        num idx = customClass.raceMoves.indexWhere((m) => m.key == move.key);
        customClass.raceMoves.removeAt(idx);
        customClass.fields['raceMoves'].setDirty(true);
        break;
      case MoveCategory.Starting:
        num idx =
            customClass.startingMoves.indexWhere((m) => m.key == move.key);
        customClass.startingMoves.removeAt(idx);
        customClass.fields['startingMoves'].setDirty(true);
        break;
      case MoveCategory.Advanced1:
        num idx =
            customClass.advancedMoves1.indexWhere((m) => m.key == move.key);
        customClass.advancedMoves1.removeAt(idx);
        customClass.fields['advancedMoves1'].setDirty(true);
        break;
      case MoveCategory.Advanced2:
        num idx =
            customClass.advancedMoves2.indexWhere((m) => m.key == move.key);
        customClass.advancedMoves2.removeAt(idx);
        customClass.fields['advancedMoves2'].setDirty(true);
        break;
    }

    _update();
  }

  void _update() {
    validityNotifier?.value =
        raceMoveMode ? customClass.raceMoves.isNotEmpty : true;
    onUpdate?.call(customClass);
  }

  void Function() _onAddTemplate({
    @required String name,
  }) =>
      () {
        final found = customClass.raceMoves.firstWhere(
          (m) => m.name == name,
          orElse: () => null,
        );

        if (found == null) {
          customClass.raceMoves.add(Move(
            name: name,
            description: '',
            explanation: '',
            classes: [],
          ));
        }
        onUpdate?.call(customClass);
      };
}

class _RaceTemplate {
  final String name;

  _RaceTemplate(this.name);
}
