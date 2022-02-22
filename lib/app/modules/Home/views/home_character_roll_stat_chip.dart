import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/roll_stats.dart';

class HomeCharacterRollStatChip extends StatelessWidget {
  final RollStat stat;

  const HomeCharacterRollStatChip({Key? key, required this.stat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).cardColor.withOpacity(0.5),
      child: InkWell(
        onTap: () => null,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 104,
          height: 38,
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconTheme(
                child: stat.icon,
                data: IconThemeData(size: 16, color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    stat.key +
                        " " +
                        (stat.modifier >= 0 ? "+" : "-") +
                        stat.modifier.abs().toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconTheme(
                child: SvgIcon(DwIcons.dice_d6),
                data: IconThemeData(
                    size: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
