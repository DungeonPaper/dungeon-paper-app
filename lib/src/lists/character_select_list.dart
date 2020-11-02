import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/lists/character_list.dart';
import 'package:flutter/material.dart';

class CharacterSelectList extends StatefulWidget {
  final Iterable<Character> selected;
  final Iterable<Character> characters;
  final void Function(Set<Character>) onChange;

  const CharacterSelectList({
    Key key,
    this.selected,
    this.characters,
    this.onChange,
  }) : super(key: key);

  @override
  _CharacterSelectListState createState() => _CharacterSelectListState();
}

class _CharacterSelectListState extends State<CharacterSelectList> {
  Set<Character> selected;

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

    return CharacterList(
      builder: (context, list) {
        return _list(list);
      },
    );
  }

  Widget _list(Iterable<Character> list) {
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
                    title: Text(char.displayName),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void Function(bool) _onChecked(Character char) {
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

  void Function(bool) _onCheckAll(Iterable<Character> list) {
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

  bool _allChecked(Iterable<Character> list) =>
      list.every((char) => selected.contains(char));
}
