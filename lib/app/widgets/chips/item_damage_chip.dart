import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemDamageChip extends StatelessWidget {
  const ItemDamageChip({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(DwIcons.dice_d6_numbered, size: 12, color: Theme.of(context).colorScheme.onPrimary),
          const SizedBox(width: 4),
          Text(
            (item.damage.isNegative ? '-' : '+') + NumberFormat('#.#').format(item.damage.abs()),
            style: TextStyle(
              fontSize: 10,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ],
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
