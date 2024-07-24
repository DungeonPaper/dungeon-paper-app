import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import '../../data/models/character_class.dart';
import 'dynamic_action_card.dart';

class CharacterClassCard extends StatelessWidget {
  const CharacterClassCard({
    super.key,
    required this.characterClass,
    this.onSave,
    this.showDice = true,
    this.showStar = true,
    this.showIcon = true,
    this.initiallyExpanded,
    this.actions = const [],
    this.expansionKey,
    this.maxContentHeight,
    this.expandable = true,
    this.highlightWords = const [],
    this.leading = const [],
    this.trailing = const [],
  });

  final CharacterClass characterClass;
  final void Function(CharacterClass characterClass)? onSave;
  final bool showDice;
  final bool showStar;
  final bool showIcon;
  final bool? initiallyExpanded;
  final Iterable<Widget> actions;
  final PageStorageKey? expansionKey;
  final double? maxContentHeight;
  final bool expandable;
  final List<String> highlightWords;
  final List<Widget> leading;
  final List<Widget> trailing;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: characterClass.name,
      description: _buildMarkdownDescription,
      maxContentHeight: maxContentHeight,
      expandable: expandable,
      expansionKey: expansionKey ?? PageStorageKey(characterClass.key),
      icon: showIcon ? Icon(characterClass.icon, size: 16) : null,
      showStar: false,
      initiallyExpanded: initiallyExpanded,
      actions: actions,
      highlightWords: highlightWords,
      leading: [
        ...leading,
        if (leading.isNotEmpty && trailing.isNotEmpty) const SizedBox(width: 8),
        ...trailing,
      ],
    );
  }

  String get _buildMarkdownDescription {
    final baseLoadLabel = tr.characterClass.baseLoad;
    final baseHpLabel = tr.characterClass.baseHp;
    final damageDiceLabel = tr.characterClass.damageDice;

    final table = [
      ' ### Base Stats',
      '| **$baseHpLabel** | **$baseLoadLabel** | **$damageDiceLabel** |',
      '| --- | --- | --- |',
      '| ${characterClass.hp} | ${characterClass.load} | ${characterClass.damageDice} |',
    ].join('\n');

    final alignmentsTable = [
      ' ### Alignments',
      '| **Alignment** | **Description** |',
      '| --- | --- |',
      for (final alignment in characterClass.alignments.values)
        if (alignment.description.isNotEmpty)
          '| ${tr.alignment.name(alignment.type.name)} | ${alignment.description} |',
    ].join('\n');

    return [
      characterClass.description,
      table,
      if (characterClass.alignments.isNotEmpty) ...[
        '',
        alignmentsTable,
      ],
    ].join('\n');
  }
}

