import 'package:dungeon_paper/app/widgets/chips/advanced_chip.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../data/models/move.dart';

class MoveCategoryChip extends StatelessWidget {
  const MoveCategoryChip({
    Key? key,
    required this.category,
    this.visualDensity,
    this.advancedLevelDisplay = AdvancedLevelDisplay.none,
  }) : super(key: key);

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
        return S.current.moveCategory(category);
      case AdvancedLevelDisplay.short:
        return S.current.moveCategoryWithLevelShort(category);
      case AdvancedLevelDisplay.full:
        return S.current.moveCategoryWithLevel(category);
    }
  }
}

enum AdvancedLevelDisplay {
  none,
  short,
  full,
}
