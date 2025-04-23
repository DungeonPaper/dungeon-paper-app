import 'package:dungeon_paper/app/modules/StandardMoves/controllers/standard_moves_list_controller.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StandardMovesListView extends StatelessWidget {
  const StandardMovesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StandardMovesListController>(
      builder: (context, controller, _) {
        final textTheme = Theme.of(context).textTheme.titleMedium!;
        return Scaffold(
          appBar: AppBar(title: Text(controller.title)),
          body: Center(
            child: SizedBox(
              width: 800,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tr.myLibrary.libraryType('builtIn'),
                      style: textTheme,
                    ),
                  ),
                  for (final move in controller.builtInMoves(context))
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MoveCard(
                        move: move,
                        showStar: false,
                        showClasses: false,
                        abilityScores: controller.args.character.abilityScores,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tr.myLibrary.libraryType('my'),
                      style: textTheme,
                    ),
                  ),
                  for (final move in controller.playbookMoves(context))
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MoveCard(
                        move: move,
                        showStar: false,
                        showClasses: false,
                        abilityScores: controller.args.character.abilityScores,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
