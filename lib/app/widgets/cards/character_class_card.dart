import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_tile.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../data/models/character_class.dart';
import 'dynamic_action_card.dart';

class CharacterClassCard extends StatelessWidget {
  const CharacterClassCard({
    Key? key,
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
    this.onExpansion,
    this.highlightWords = const [],
  }) : super(key: key);

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
  final CancellableValueChanged<bool>? onExpansion;
  final List<String> highlightWords;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: characterClass.name,
      description: _buildMarkdownDescription,
      maxContentHeight: maxContentHeight,
      expandable: expandable,
      onExpansion: onExpansion,
      expansionKey: expansionKey ?? PageStorageKey(characterClass.key),
      icon: showIcon ? Icon(characterClass.icon, size: 16) : null,
      showStar: false,
      initiallyExpanded: initiallyExpanded,
      actions: actions,
      highlightWords: highlightWords,
    );
  }

  String get _buildMarkdownDescription {
    final baseLoadLabel = S.current.formCharacterClassBaseLoad;
    final baseHpLabel = S.current.formCharacterClassBaseHp;
    final table = [
      '| $baseHpLabel | $baseLoadLabel |',
      '| --- | --- |',
      '| ${characterClass.hp} | ${characterClass.load} |',
    ].join('\n');
    return characterClass.description + '\n\n' + table;
  }
}
