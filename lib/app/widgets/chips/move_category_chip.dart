import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import '../../data/models/move.dart';

class MoveCategoryChip extends StatelessWidget {
  const MoveCategoryChip({
    super.key,
    required this.category,
    this.visualDensity,
    this.advancedLevelDisplay = AdvancedLevelDisplay.none,
  });

  final MoveCategory category;
  final AdvancedLevelDisplay advancedLevelDisplay;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    return PrimaryChip(
      label: _text,
      visualDensity: visualDensity ?? VisualDensity.compact,
    );
  }

  String get _text {
    switch (advancedLevelDisplay) {
      case AdvancedLevelDisplay.none:
        return tr.moves.category.shortName(category.name);
      case AdvancedLevelDisplay.short:
        return tr.moves.category.mediumName(category.name);
      case AdvancedLevelDisplay.full:
        return tr.moves.category.longName(category.name);
    }
  }
}

enum AdvancedLevelDisplay {
  none,
  short,
  full,
}
