import 'package:dungeon_paper/src/lists/player_class_list.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class CustomClassSelectList extends StatefulWidget {
  final Iterable<PlayerClass> selected;
  final Iterable<PlayerClass> characters;
  final void Function(Set<PlayerClass>) onChange;

  const CustomClassSelectList({
    Key key,
    this.selected,
    this.characters,
    this.onChange,
  }) : super(key: key);

  @override
  _CustomClassSelectListState createState() => _CustomClassSelectListState();
}

class _CustomClassSelectListState extends State<CustomClassSelectList> {
  Set<PlayerClass> selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected != null ? Set.from(widget.selected) : {};
  }

  @override
  Widget build(BuildContext context) {
    if (widget.characters?.isNotEmpty == true) {
      return _list(widget.characters);
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
            child: Column(
              children: [
                CheckboxListTile(
                  value: _allChecked(list),
                  onChanged: _onCheckAll(list),
                  title: Text(
                    'Select All',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                    ),
                  ),
                ),
                Divider(),
                for (var char in list)
                  CheckboxListTile(
                    secondary: Icon(Icons.person),
                    dense: true,
                    value: selected.contains(char),
                    onChanged: _onChecked(char),
                    title: Text(char.name),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void Function(bool) _onChecked(PlayerClass char) {
    return (bool state) {
      setState(() {
        if (state) {
          selected.add(char);
        } else {
          selected.remove(char);
        }
        widget.onChange?.call(selected);
      });
    };
  }

  void Function(bool) _onCheckAll(Iterable<PlayerClass> list) {
    return (bool state) {
      setState(() {
        if (state) {
          selected = list.toSet();
        } else {
          selected = {};
        }
        widget.onChange?.call(selected);
      });
    };
  }

  bool _allChecked(Iterable<PlayerClass> list) =>
      list.every((char) => selected.contains(char));
}
