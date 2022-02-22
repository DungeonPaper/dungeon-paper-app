import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../data/models/move.dart';

class MoveCategoryChip extends StatelessWidget {
  const MoveCategoryChip({Key? key, required this.category}) : super(key: key);

  final MoveCategory category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Text(
        S.current.moveCategory(category),
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
}
