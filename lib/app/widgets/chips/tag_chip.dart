import 'package:dungeon_paper/app/model_utils/tag_utils.dart';
import 'package:dungeon_paper/app/widgets/chips/advanced_chip.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:flutter/material.dart';

import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class TagChip extends StatelessWidget {
  const TagChip({
    Key? key,
    required this.tag,
    this.onPressed,
    this.onDeleted,
    this.icon,
    this.backgroundColor,
  }) : super(key: key);

  final dw.Tag tag;
  final void Function()? onPressed;
  final void Function()? onDeleted;
  final Widget? icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = toTitleCase(tag.name);

    return AdvancedChip(
      deleteIconColor: Theme.of(context).colorScheme.onPrimary,
      avatar: IconTheme(
        data: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
          size: 16,
        ),
        child: icon != null ? icon! : TagUtils.iconOf(tag),
      ),
      label: Text(
        tag.value != null ? '$name: ${tag.value}' : name,
        style: TextStyle(
          color: theme.colorScheme.onPrimary,
        ),
      ),
      backgroundColor: backgroundColor ?? theme.primaryColor.withOpacity(0.7),
      labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      isEnabled: true,
      onDeleted: onDeleted,
      onPressed: onPressed,
    );
  }
}
