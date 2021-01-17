import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final Tag tag;
  final void Function(Tag tag) onDelete;
  final void Function(Tag tag) onPressed;
  final VisualDensity visualDensity;

  const TagChip({
    Key key,
    this.tag,
    this.onDelete,
    this.onPressed,
    this.visualDensity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var label = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.label, size: 14),
        SizedBox(width: 4),
        Text(tag?.name != null ? capitalize(tag.toString()) : 'Add tag'),
      ],
    );
    var onPressCb = pass1(onPressed, tag);
    var onDeleteCb = pass1(onDelete, tag);

    if (onPressed == null) {
      return Chip(
        onDeleted: onDeleteCb,
        label: label,
        visualDensity: visualDensity,
      );
    }

    return InputChip(
      onPressed: onPressCb,
      onDeleted: onDeleteCb,
      label: label,
      visualDensity: visualDensity,
    );
  }
}
