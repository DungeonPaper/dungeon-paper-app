import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/widgets/chips/move_category_chip.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import 'dynamic_action_card.dart';

class AlignmentValueCard extends StatelessWidget {
  const AlignmentValueCard({
    super.key,
    required this.alignment,
    this.onSave,
    this.showStar = false,
    this.showIcon = true,
    this.initiallyExpanded,
    this.actions = const [],
    this.expansionKey,
    this.maxContentHeight,
    this.expandable = true,
    this.advancedLevelDisplay = AdvancedLevelDisplay.short,
    this.highlightWords = const [],
    this.showClasses = false,
    this.leading = const [],
    this.trailing = const [],
  });

  final AlignmentValue alignment;
  final void Function(AlignmentValue alignment)? onSave;
  final bool showStar;
  final bool showIcon;
  final bool? initiallyExpanded;
  final Iterable<Widget> actions;
  final PageStorageKey? expansionKey;
  final double? maxContentHeight;
  final bool expandable;
  final AdvancedLevelDisplay advancedLevelDisplay;
  final List<String> highlightWords;
  final bool showClasses;
  final List<Widget> leading;
  final List<Widget> trailing;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      title: tr.alignment.name(alignment.key),
      description: alignment.description,
      maxContentHeight: maxContentHeight,
      expandable: expandable,
      expansionKey: expansionKey ?? PageStorageKey(alignment.key),
      dice: const [],
      icon: showIcon ? Icon(alignment.icon, size: 16) : null,
      // starred: alignment.favorite,
      showStar: showStar,
      // onStarChanged: (favorite) =>
      //     onSave?.call(alignment.copyWithInherited(favorite: favorite)),
      initiallyExpanded: initiallyExpanded,
      actions: actions,
      highlightWords: highlightWords,
      leading: [
        ...leading,
        // mid items
        if (trailing.isNotEmpty) const SizedBox(width: 8),
        ...trailing,
      ].joinObjects(const SizedBox(width: 8)),
    );
  }
}
