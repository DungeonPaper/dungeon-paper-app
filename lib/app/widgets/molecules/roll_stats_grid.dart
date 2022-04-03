import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:flutter/material.dart';

import '../chips/roll_stat_chip.dart';

class RollStatsGrid extends StatelessWidget {
  const RollStatsGrid({
    Key? key,
    required this.rollStats,
    this.showDice = true,
  }) : super(key: key);

  final List<RollStat> rollStats;
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
            for (var stat in rollStats)
              SizedBox(
                width: constraints.maxWidth / 3 - 8,
                child: RollStatChip(
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
