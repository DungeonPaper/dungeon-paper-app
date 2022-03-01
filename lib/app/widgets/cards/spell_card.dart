import 'package:flutter/material.dart';

import '../../data/models/spell.dart';
import 'dynamic_action_card.dart';

class SpellCard extends StatelessWidget {
  const SpellCard({
    Key? key,
    required this.spell,
    this.showDice = true,
  }) : super(key: key);

  final Spell spell;
  final bool showDice;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: spell.name,
      body: [Text(spell.description)],
      chips: const [],
      dice: showDice ? spell.dice : [],
      icon: spell.icon,
      starred: spell.prepared,
    );
  }
}
