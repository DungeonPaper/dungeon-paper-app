import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemDamageChip extends StatelessWidget {
  const ItemDamageChip({
    Key? key,
    required this.item,
    this.visualDensity,
  }) : super(key: key);

  final Item item;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    return PrimaryChip(
      icon: const Icon(DwIcons.dice_d6_numbered),
      label: (item.damage.isNegative ? '-' : '+') + NumberFormat('#.#').format(item.damage.abs()),
      visualDensity: visualDensity ?? VisualDensity.compact,
    );
  }
}
