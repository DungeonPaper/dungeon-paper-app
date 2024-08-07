import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/chips/item_amount_chip.dart';
import 'package:dungeon_paper/app/widgets/chips/item_armor_chip.dart';
import 'package:dungeon_paper/app/widgets/chips/item_damage_chip.dart';
import 'package:dungeon_paper/app/widgets/chips/item_weight_chip.dart';
import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popover/popover.dart';

import '../../data/models/item.dart';
import 'dynamic_action_card.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
    this.showStar = true,
    this.hideCount = false,
    this.showIcon = true,
    this.onSave,
    this.initiallyExpanded,
    this.actions = const [],
    this.expansionKey,
    this.maxContentHeight,
    this.expandable = true,
    this.highlightWords = const [],
    this.reorderablePadding = false,
    this.leading = const [],
    this.trailing = const [],
  });

  final Item item;
  final bool showStar;
  final bool hideCount;
  final bool showIcon;
  final bool? initiallyExpanded;
  final void Function(Item item)? onSave;
  final Iterable<Widget> actions;
  final PageStorageKey? expansionKey;
  final double? maxContentHeight;
  final bool expandable;
  final List<String> highlightWords;
  final bool reorderablePadding;
  final List<Widget> leading;
  final List<Widget> trailing;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[
      if (item.damage != 0) ...[
        ItemDamageChip(item: item),
      ],
      if (item.weight > 0) ...[
        ItemWeightChip(item: item),
      ],
      if (item.armor > 0) ...[
        ItemArmorChip(item: item),
      ],
      if (!hideCount && item.amount != 1) ...[
        ItemAmountChip(item: item),
      ],
    ];
    final tags = item.tags
        .map<Widget>((t) => TagChip.openDescription(context, tag: t))
        .toList();
    if (!hideCount) {
      tags.add(
        Builder(builder: (context) {
          return TagChip(
            tag: Tag(
              name: 'Amount',
              value: NumberFormat('#.#').format(item.amount),
            ),
            onPressed: () => showPopover(
              context: context,
              height: 64,
              width: 200,
              backgroundColor: Theme.of(context).cardColor,
              // direction: PopoverDirection.right,
              direction: PopoverDirection.top,
              bodyBuilder: (context) => Container(
                color: Theme.of(context).cardColor,
                child: NumberTextField(
                  numberType: NumberType.double,
                  onChanged: (str) => onSave?.call(
                    item.copyWithInherited(
                      amount: double.tryParse(str) ?? item.amount,
                    ),
                  ),
                  controller: TextEditingController(
                    text: item.amount.toString(),
                  ),
                ),
              ),
            ),
          );
        }),
      );
    }
    return DynamicActionCard(
      initiallyExpanded: initiallyExpanded,
      title: item.name,
      description: item.description,
      maxContentHeight: maxContentHeight,
      expandable: expandable,
      explanation: '',
      reorderablePadding: reorderablePadding,
      leading: [
        ...leading,
        ...chips,
        ...trailing,
      ].joinObjects(const SizedBox(width: 8)),
      chips: tags,
      dice: const [],
      icon: showIcon ? Icon(item.icon, size: 16) : null,
      starred: item.equipped,
      showStar: showStar,
      onStarChanged: (equipped) =>
          onSave?.call(item.copyWithInherited(equipped: equipped)),
      actions: actions,
      expansionKey: expansionKey ?? PageStorageKey(item.key),
      highlightWords: highlightWords,
    );
  }
}
