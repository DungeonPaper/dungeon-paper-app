import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/redux/connectors.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:flutter/material.dart';

class CharacterList extends StatelessWidget {
  final Widget Function(BuildContext, List<Character>) builder;

  const CharacterList({
    Key key,
    @required this.builder,
  }) : super(key: key);

  factory CharacterList.dropdown({
    Character value,
    bool includeCustom = true,
    bool includeDefault = true,
    @required void Function(Character) onChanged,
  }) =>
      CharacterList(
        builder: (context, list) => DropdownButton(
          isExpanded: true,
          value: list.firstWhere((cls) => cls.documentID == value.documentID,
              orElse: () => list.first),
          onChanged: onChanged,
          items: [
            for (var cls in list)
              DropdownMenuItem(value: cls, child: Text(cls.displayName)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector<List<Character>>(
      builder: builder,
      converter: (store) {
        return dwStore.state.characters.all.values.toList()
          ..sort((a, b) => a.order - b.order);
      },
    );
  }
}
