import 'package:flutter/material.dart';

import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class TagChip extends StatelessWidget {
  const TagChip({Key? key, required this.tag}) : super(key: key);

  final dw.Tag tag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Text(
        tag.value != null ? '${tag.name}: ${tag.value}' : tag.name,
        style: TextStyle(
          color: theme.colorScheme.onPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: ShapeDecoration(
        color: theme.primaryColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      // labelPadding: EdgeInsets.zero,
    );
  }
}
