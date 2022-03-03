import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:flutter/material.dart';

import '../../data/models/spell.dart';
import 'dynamic_action_card_mini.dart';

class SpellCardMini extends StatelessWidget {
  const SpellCardMini({
    Key? key,
    required this.spell,
    this.showDice = true,
    this.showStar = true,
  }) : super(key: key);

  final Spell spell;
  final bool showDice;
  final bool showStar;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCardMini(
      title: spell.name,
      description: spell.description,
      chips: const [],
      dice: showDice ? spell.dice : [],
      icon: SvgIcon(spell.icon, size: 16),
      starred: spell.prepared,
      showStar: showStar,
    );
  }
}
