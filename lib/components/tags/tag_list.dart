import 'package:dungeon_world_data/tag.dart';
import 'package:flutter/material.dart';
import 'tag.dart';

class TagList extends StatelessWidget {
  final List<Tag> tags;

  const TagList({
    Key key,
    @required this.tags,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: [
        for (num i = 0; i < tags.length; i++)
          Padding(
            padding: EdgeInsets.only(right: 4),
            child: TagChip(
              tag: tags[i],
              onPressed: (tag) {
                showDialog(
                  context: context,
                  builder: (ctx) => TagDescription(tag),
                );
              },
            ),
          ),
      ],
    );
  }

  void onSave(Tag tag) {

  }
}
