import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class SpellLevelChip extends StatelessWidget {
  const SpellLevelChip({
    super.key,
    required this.level,
    this.visualDensity,
  });

  final String level;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    return PrimaryChip(
      label: tr.spells.spellLevel(level),
      visualDensity: visualDensity ?? VisualDensity.compact,
    );
  }
}
