import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
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
      tooltip: dw.dungeonWorldData.tags['Weight']!.description,
      visualDensity: visualDensity ?? VisualDensity.compact,
    );
  }
}
