import 'package:dungeon_world_data/tag.dart';
import 'package:flutter/material.dart';
import '../../utils.dart';

class TagChip extends StatelessWidget {
  final Tag tag;
  final void Function(Tag tag) onDelete;
  final void Function(Tag tag) onPressed;

  const TagChip({
    Key key,
    this.tag,
    this.onDelete,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var label = Text(tag != null ? capitalize(tag.toString()) : 'Add tag');
    if (onPressed == null)
      return Chip(
        onDeleted: onDelete != null ? () => onDelete(tag) : null,
        label: label,
      );

    return InputChip(
      onPressed: onPressed != null ? () => onPressed(tag) : null,
      onDeleted: onDelete != null ? () => onDelete(tag) : null,
      label: label,
    );
  }
}
