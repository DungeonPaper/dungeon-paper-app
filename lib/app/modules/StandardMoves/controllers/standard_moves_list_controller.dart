import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/core/route_arguments.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class StandardMovesListController extends ChangeNotifier {
  late StandardMovesArgs args;

  StandardMovesListController(BuildContext context) {
    args = getArgs(context);
  }

  String get title {
    switch (args.category) {
      case MoveCategory.basic:
        return tr.actions.moves.basic;
      case MoveCategory.special:
        return tr.actions.moves.special;
      default:
        return '';
    }
  }

  List<Move> builtInMoves(BuildContext context) {
    final repo = RepositoryProvider.of(context);
    switch (args.category) {
      case MoveCategory.basic:
        return repo.builtIn
            .listByType<Move>()
            .values
            .where((move) => move.category == MoveCategory.basic)
            .toList();
      case MoveCategory.special:
        return repo.builtIn
            .listByType<Move>()
            .values
            .where((move) => move.category == MoveCategory.special)
            .toList();
      default:
        return [];
    }
  }

  List<Move> playbookMoves(BuildContext context) {
    final repo = RepositoryProvider.of(context);
    switch (args.category) {
      case MoveCategory.basic:
        return repo.my
            .listByType<Move>()
            .values
            .where((move) => move.category == MoveCategory.basic)
            .toList();
      case MoveCategory.special:
        return repo.my
            .listByType<Move>()
            .values
            .where((move) => move.category == MoveCategory.special)
            .toList();
      default:
        return [];
    }
  }
}

class StandardMovesArgs {
  final MoveCategory category;
  final Character character;

  StandardMovesArgs({required this.category, required this.character});
}
