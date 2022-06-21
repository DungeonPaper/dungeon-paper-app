import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemWeightChip extends StatelessWidget {
  const ItemWeightChip({
    Key? key,
    required this.item,
    this.visualDensity,
  }) : super(key: key);

  final Item item;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    return PrimaryChip(
      icon: const Icon(DwIcons.dumbbell),
      label: NumberFormat('#.#').format(item.amount * item.weight),
      visualDensity: visualDensity ?? VisualDensity.compact,
    );
  }
}
