import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:flutter/material.dart';

import 'dynamic_action_card_mini.dart';

class NoteCardMini extends StatelessWidget {
  const NoteCardMini({
    Key? key,
    required this.note,
    this.showStar = true,
    this.showIcon = true,
    this.onSave,
    this.onTap,
  }) : super(key: key);

  final Note note;
  final bool showStar;
  final bool showIcon;
  final void Function(Note note)? onSave;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCardMini(
      title: note.title,
      description: note.description,
      chips: const [],
      dice: const [],
      icon: showIcon ? Icon(note.icon, size: 16) : null,
      starred: note.favorite,
      showStar: showStar,
      onStarChanged: (favorite) =>
          onSave?.call(note.copyWith(favorite: favorite)),
      onTap: onTap,
    );
  }
}
