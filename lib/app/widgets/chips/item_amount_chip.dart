import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/services/intl_service.dart';

class ItemAmountChip extends StatelessWidget {
  const ItemAmountChip({
    super.key,
    required this.item,
    this.visualDensity,
  });

  final Item item;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    return PrimaryChip(
      label: tr.items.amount(NumberFormat('#.##').format(item.amount)),
      tooltip: tr.items.amountTooltip,
      visualDensity: visualDensity ?? VisualDensity.compact,
    );
  }
}
