import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/app/widgets/chips/spell_level_chip.dart';
import 'package:flutter/material.dart';

import '../../data/models/spell.dart';
import 'dynamic_action_card_mini.dart';

class SpellCardMini extends StatelessWidget {
  const SpellCardMini({
    Key? key,
    required this.spell,
    this.showDice = true,
    this.showStar = true,
    this.showIcon = true,
    this.onSave,
    this.onTap,
  }) : super(key: key);

  final Spell spell;
  final bool showDice;
  final bool showStar;
  final bool showIcon;
  final void Function(Spell spell)? onSave;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCardMini(
      title: spell.name,
      description: spell.description,
      chips: [SpellLevelChip(level: spell.level)],
      dice: showDice ? spell.dice : [],
      icon: showIcon ? SvgIcon(spell.icon, size: 16) : null,
      starred: spell.prepared,
      showStar: showStar,
      onStarChanged: (prepared) => onSave?.call(spell.copyWithInherited(prepared: prepared)),
      onTap: onTap,
    );
  }
}
