import 'package:flutter/material.dart';

import '../../data/models/spell.dart';
import 'dynamic_action_card_mini.dart';

class SpellCardMini extends StatelessWidget {
  const SpellCardMini({Key? key, required this.spell}) : super(key: key);

  final Spell spell;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCardMini(
      title: spell.name,
      description: spell.description,
      chips: const [],
      dice: spell.dice,
      icon: spell.icon,
      starred: spell.prepared,
    );
  }
}
