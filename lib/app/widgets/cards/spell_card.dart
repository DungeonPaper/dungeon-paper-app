import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:flutter/material.dart';

import '../../data/models/spell.dart';
import 'dynamic_action_card.dart';

class SpellCard extends StatelessWidget {
  const SpellCard({
    Key? key,
    required this.spell,
    this.showDice = true,
    this.showStar = true,
    this.showIcon = true,
    this.onSave,
    this.initiallyExpanded,
    this.actions = const [],
    this.expansionKey,
  }) : super(key: key);

  final Spell spell;
  final bool showDice;
  final bool showStar;
  final bool showIcon;
  final bool? initiallyExpanded;
  final void Function(Spell spell)? onSave;
  final Iterable<Widget> actions;
  final PageStorageKey? expansionKey;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: spell.name,
      description: spell.description,
      explanation: spell.explanation,
      chips: const [],
      dice: showDice ? spell.dice : [],
      icon: showIcon ? SvgIcon(spell.icon, size: 16) : null,
      starred: spell.prepared,
      showStar: showStar,
      onStarChanged: (prepared) => onSave?.call(spell.copyWithInherited(prepared: prepared)),
      initiallyExpanded: initiallyExpanded,
      actions: actions,
      expansionKey: expansionKey ?? PageStorageKey(spell.key),
    );
  }
}
