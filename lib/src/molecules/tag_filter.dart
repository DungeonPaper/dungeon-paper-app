import 'package:dungeon_paper/src/atoms/advanced_filter_chip.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:flutter/material.dart';

class TagFilter extends StatelessWidget {
  final Iterable<Tag> tags;
  final Iterable<Tag> selected;
  final void Function(Iterable<Tag>) onChanged;

  const TagFilter({
    Key key,
    @required this.tags,
    @required this.selected,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final tag in tags)
          AdvancedFilterChip(
            value: tag,
            label: Text(capitalize(tag.name)),
            selected: isSelected(tag),
            onChanged: _onChanged(tag),
          ),
      ],
    );
  }

  bool isSelected(Tag tag) =>
      selected.firstWhere((element) => element.name == tag.name,
          orElse: () => null) !=
      null;

  Function _onChanged(Tag tag) => (v) {
        final newSelected = [...selected]
          ..removeWhere((t) => t.name == tag.name);
        if (v != null) {
          newSelected.add(v);
        }

        onChanged?.call(newSelected);
      };
}
