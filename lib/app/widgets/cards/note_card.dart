import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:flutter/material.dart';

import '../../data/models/note.dart';
import 'dynamic_action_card.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    Key? key,
    required this.note,
    this.showStar = true,
    this.showIcon = true,
    this.onSave,
    this.initiallyExpanded,
    this.actions = const [],
    this.expansionKey,
    this.maxContentHeight,
    this.expandable = true,
    this.highlightWords = const [],
  }) : super(key: key);

  final Note note;
  final bool showStar;
  final bool showIcon;
  final bool? initiallyExpanded;
  final void Function(Note note)? onSave;
  final Iterable<Widget> actions;
  final PageStorageKey? expansionKey;
  final double? maxContentHeight;
  final bool expandable;
  final List<String> highlightWords;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCard(
      initiallyExpanded: initiallyExpanded,
      title: note.title,
      description: note.description,
      explanation: '',
      maxContentHeight: maxContentHeight,
      expandable: expandable,
      chips: note.tags.map((t) => TagChip.openDescription(tag: t)),
      dice: const [],
      icon: showIcon ? Icon(note.icon, size: 16) : null,
      starred: note.favorited,
      showStar: showStar,
      onStarChanged: (favorited) => onSave?.call(note.copyWith(favorited: favorited)),
      actions: actions,
      expansionKey: expansionKey ?? PageStorageKey(note.key),
      highlightWords: highlightWords,
    );
  }
}
