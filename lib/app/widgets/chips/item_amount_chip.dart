import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';

class ItemAmountChip extends StatelessWidget {
  const ItemAmountChip({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Text(
        S.current.itemAmountX(NumberFormat('#.##').format(item.amount)),
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
