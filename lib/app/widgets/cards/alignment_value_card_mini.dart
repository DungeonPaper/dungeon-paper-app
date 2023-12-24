import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import '../../data/models/alignment.dart';
import 'dynamic_action_card_mini.dart';

class AlignmentValueCardMini extends StatelessWidget {
  const AlignmentValueCardMini({
    super.key,
    required this.alignment,
    this.onSave,
    this.showStar = false,
    this.showIcon = true,
    this.onTap,
  });

  final AlignmentValue alignment;
  final bool showStar;
  final bool showIcon;
  final void Function(AlignmentValue alignment)? onSave;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DynamicActionCardMini(
      title: tr.alignment.name(alignment.key),
      description: alignment.description,
      chips: const [],
      dice: const [],
      icon: showIcon ? Icon(alignment.icon, size: 16) : null,
      // starred: alignment.favorite,
      starred: false,
      showStar: showStar,
      // ignore: avoid_returning_null_for_void
      onStarChanged: (_) => null,
      // onStarChanged: (favorite) =>
      //     onSave?.call(alignment.copyWithInherited(favorite: favorite)),
      onTap: onTap,
    );
  }
}
