import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../data/models/move.dart';

class MoveCategoryChip extends StatelessWidget {
  const MoveCategoryChip({
    Key? key,
    required this.category,
    this.advancedLevelDisplay = AdvancedLevelDisplay.none,
  }) : super(key: key);

  final MoveCategory category;
  final AdvancedLevelDisplay advancedLevelDisplay;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Text(
        _text,
        style: TextStyle(
          fontSize: 10,
          color: theme.colorScheme.onPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: ShapeDecoration(
        color: theme.primaryColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      // labelPadding: EdgeInsets.zero,
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
