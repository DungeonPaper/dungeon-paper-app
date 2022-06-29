import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class ItemArmorChip extends StatelessWidget {
  const ItemArmorChip({
    Key? key,
    required this.item,
    this.visualDensity,
  }) : super(key: key);

  final Item item;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    return PrimaryChip(
      icon: const Icon(DwIcons.armor),
      label: NumberFormat('#.#').format(item.armor),
      visualDensity: visualDensity ?? VisualDensity.compact,
      tooltip: dw.dungeonWorldData.tags['Armor']!.description,
    );
  }
}
