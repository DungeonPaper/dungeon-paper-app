import 'package:dungeon_world_data/tag.dart';
import 'package:flutter/material.dart';

class TagList extends StatelessWidget {
  const TagList({
    Key key,
    @required this.tags,
  }) : super(key: key);

  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: tags
          .map(
            (tag) => Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Chip(
                    label: Text(
                      tag.hasValues
                          ? tag.values.keys
                              .map((k) => '$k: ${tag.values[k]}')
                              .join(' ')
                          : tag.name,
                    ),
                  ),
                ),
          )
          .toList(),
    );
  }
}
