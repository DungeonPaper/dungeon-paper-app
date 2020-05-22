import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:flutter/material.dart';

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
    var onPressCb = pass1(onPressed, tag);
    var onDeleteCb = pass1(onDelete, tag);

    if (onPressed == null) {
      return Chip(
        onDeleted: onDeleteCb,
        label: label,
      );
    }

    return InputChip(
      onPressed: onPressCb,
      onDeleted: onDeleteCb,
      label: label,
    );
  }
}
