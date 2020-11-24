import 'package:dungeon_paper/src/lists/player_class_list.dart';
import 'package:dungeon_paper/src/lists/selectable_list.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class CustomClassSelectList extends StatelessWidget {
  final Iterable<PlayerClass> selected;
  final Iterable<PlayerClass> classes;
  final void Function(Set<PlayerClass>) onChange;

  const CustomClassSelectList({
    Key key,
    this.selected,
    this.classes,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (classes?.isNotEmpty == true) {
      return _list(classes);
    }

    return PlayerClassList(
      includeDefault: false,
      builder: (context, list) {
        return _list(list);
      },
    );
  }

  Widget _list(Iterable<PlayerClass> list) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Flexible(
            child: SelectableList.checkboxTile(
              list: list,
              selected: selected,
              onChange: onChange,
              titleBuilder: (cls, _idx, context) => Text(cls.name),
            ),
          ),
        ],
      ),
    );
  }
}
