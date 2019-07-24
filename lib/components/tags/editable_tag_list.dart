import 'package:dungeon_paper/components/tags/edit_tag.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:flutter/material.dart';
import 'tag.dart';

class EditableTagList extends StatelessWidget {
  final List<Tag> tags;
  final void Function(Tag tag, num index) onDelete;
  final void Function(Tag tag, num index) onSave;

  const EditableTagList({Key key, List<Tag> tags, this.onDelete, this.onSave})
      : tags = tags ?? const [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 5.0,
      children: [
        for (num i = 0; i < tags.length; i++)
          TagChip(
            tag: tags[i],
            onPressed: (tag) => openEditDialog(context, i, tag),
            onDelete: handleDelete(i),
          ),
        TagChip(
          tag: null,
          onPressed: (tag) => openEditDialog(context, tags.length, tag),
        ),
      ],
    );
  }

  handleDelete(num idx) {
    return (Tag tag) {
      if (onDelete == null) return;
      onDelete(tag, idx);
    };
  }

  void openEditDialog(BuildContext context, num idx, Tag tag) {
    showDialog(
      context: context,
      builder: (ctx) => EditTagDialog(
          tag: tag,
          onSave: (tag) {
            if (onSave == null) return;
              onSave(tag, idx);
          }),
    );
  }
}
