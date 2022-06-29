import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../generated/l10n.dart';

class ItemAmountChip extends StatelessWidget {
  const ItemAmountChip({
    Key? key,
    required this.item,
    this.visualDensity,
  }) : super(key: key);

  final Item item;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    return PrimaryChip(
      label: S.current.itemAmountX(NumberFormat('#.##').format(item.amount)),
      tooltip: S.current.amount,
      visualDensity: visualDensity ?? VisualDensity.compact,
    );
  }
}
