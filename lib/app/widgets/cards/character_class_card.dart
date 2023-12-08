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
    );
  }

  String get _buildMarkdownDescription {
    final baseLoadLabel = tr.characterClass.baseLoad;
    final baseHpLabel = tr.characterClass.baseHp;
    final table = [
      '| $baseHpLabel | $baseLoadLabel |',
      '| --- | --- |',
      '| ${characterClass.hp} | ${characterClass.load} |',
    ].join('\n');
    return '${characterClass.description}\n\n$table';
  }
}
