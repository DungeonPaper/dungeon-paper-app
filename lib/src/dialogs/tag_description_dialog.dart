import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/tag.dart';

class TagDescriptionDialog extends StatelessWidget {
  final Tag tag;

  const TagDescriptionDialog(this.tag, {Key key}) : super(key: key);

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
      ],
    );
  }
}
