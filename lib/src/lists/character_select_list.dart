import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/lists/character_list.dart';
import 'package:dungeon_paper/src/lists/selectable_list.dart';
import 'package:flutter/material.dart';

class CharacterSelectList extends StatelessWidget {
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
  Widget build(BuildContext context) {
    if (characters?.isNotEmpty == true) {
      return _list(characters);
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
            child: SelectableList.checkboxTile(
              list: list,
              selected: selected,
              onChange: onChange,
              titleBuilder: (char, _idx, context) => Text(char.displayName),
            ),
          ),
        ],
      ),
    );
  }
}
