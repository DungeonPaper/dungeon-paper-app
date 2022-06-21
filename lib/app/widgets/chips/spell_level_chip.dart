import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class SpellLevelChip extends StatelessWidget {
  const SpellLevelChip({
    Key? key,
    required this.level,
    this.visualDensity,
  }) : super(key: key);

  final String level;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PrimaryChip(
      label: S.current.spellLevel(level),
      visualDensity: visualDensity ?? VisualDensity.compact,
    );
  }
}
