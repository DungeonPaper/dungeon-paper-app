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
    this.onSave,
    this.initiallyExpanded,
  }) : super(key: key);

  final Spell spell;
  final bool showDice;
  final bool showStar;
  final bool? initiallyExpanded;
  final void Function(Spell spell)? onSave;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: spell.name,
      description: spell.description,
      chips: const [],
      dice: showDice ? spell.dice : [],
      icon: SvgIcon(spell.icon, size: 16),
      starred: spell.prepared,
      showStar: showStar,
      onStarChanged: (prepared) => onSave?.call(spell.copyWithInherited(prepared: prepared)),
      initiallyExpanded: initiallyExpanded,
    );
  }
}
