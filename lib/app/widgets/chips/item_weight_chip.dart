import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemWeightChip extends StatelessWidget {
  const ItemWeightChip({
    super.key,
    required this.item,
    this.visualDensity,
  });

  final Item item;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    return PrimaryChip(
      icon: const Icon(DwIcons.dumbbell),
      label: NumberFormat('#.#').format(item.weight),
      tooltip: dw.dungeonWorldData.tags['Weight']!.description,
      visualDensity: visualDensity ?? VisualDensity.compact,
    );
  }
}
