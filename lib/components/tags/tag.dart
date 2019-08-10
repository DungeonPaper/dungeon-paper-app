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
    var onPressCb = pass1(onPressed, tag);
    var onDeleteCb = pass1(onDelete, tag);

    if (onPressed == null)
      return Chip(
        onDeleted: onDeleteCb,
        label: label,
      );

    return InputChip(
      onPressed: onPressCb,
      onDeleted: onDeleteCb,
      label: label,
    );
  }
}

class TagDescription extends StatelessWidget {
  final Tag tag;

  const TagDescription(this.tag, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(capitalize(tag.name)),
      contentPadding: EdgeInsets.all(24).copyWith(top: 16),
      children: <Widget>[
        ...[
          Text('Description', style: Theme.of(context).textTheme.caption),
          Text(tag.description != null && tag.description.isNotEmpty
              ? tag.description
              : 'No description provided'),
        ],
        SizedBox(height: 16),
        if (tag.hasValue) ...[
          Text('Value', style: Theme.of(context).textTheme.caption),
          Text(tag.value.toString()),
        ],
        // StandardDialogControls(
        //   okText: Text('Edit'),
        //   onOK: () => showDialog(
        //       context: context, builder: (context) => EditTagDialog(tag: tag)),
        // ),
      ],
    );
  }
}
