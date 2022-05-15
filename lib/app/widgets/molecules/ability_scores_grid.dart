import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:flutter/material.dart';

import '../chips/ability_score_chip.dart';

class AbilityScoresGrid extends StatelessWidget {
  const AbilityScoresGrid({
    Key? key,
    required this.abilityScores,
    this.showDice = true,
  }) : super(key: key);

  final List<AbilityScore> abilityScores;
  final bool showDice;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: LayoutBuilder(builder: (context, constraints) {
        return Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            for (var stat in abilityScores)
              SizedBox(
                width: constraints.maxWidth / 3 - 8,
                child: AbilityScoreChip(
                  stat: stat,
                  showDice: showDice,
                ),
              ),
          ],
        );
      }),
    );
  }
}
