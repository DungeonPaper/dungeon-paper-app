import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class SpellLevelChip extends StatelessWidget {
  const SpellLevelChip({Key? key, required this.level}) : super(key: key);

  final String level;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Text(
        S.current.spellLevel(level),
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
