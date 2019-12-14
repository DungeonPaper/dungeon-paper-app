import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class PlayerClassList extends StatelessWidget {
  final PlayerClass value;
  final void Function(PlayerClass) onChanged;
  final Widget Function(BuildContext, PlayerClass, List<PlayerClass>,
      void Function(PlayerClass)) builder;

  const PlayerClassList({
    Key key,
    this.value,
    @required this.onChanged,
    @required this.builder,
  }) : super(key: key);

  factory PlayerClassList.dropdown({
    PlayerClass value,
    @required void Function(PlayerClass) onChanged,
  }) =>
      PlayerClassList(
        builder: (context, value, list, onChanged) => DropdownButton(
          isExpanded: true,
          value: value,
          onChanged: onChanged,
          items: list
              .map((cls) => DropdownMenuItem(value: cls, child: Text(cls.name)))
              .toList(),
        ),
        onChanged: onChanged,
        value: value,
      );

  @override
  Widget build(BuildContext context) {
    return builder(context, value, dungeonWorld.classes.values.toList(), onChanged);
  }
}
