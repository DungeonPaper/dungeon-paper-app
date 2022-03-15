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
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.98,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        for (var stat in rollStats)
          RollStatChip(
            stat: stat,
            showDice: showDice,
          ),
      ],
    );
  }
}
