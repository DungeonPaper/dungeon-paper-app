import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class PlayerClassList extends StatelessWidget {
  final Widget Function(BuildContext, List<PlayerClass>) builder;
  final bool includeCustom;
  final bool includeDefault;

  const PlayerClassList({
    Key key,
    @required this.builder,
    this.includeCustom = true,
    this.includeDefault = true,
  }) : super(key: key);

  factory PlayerClassList.dropdown({
    PlayerClass value,
    bool includeCustom = true,
    bool includeDefault = true,
    @required void Function(PlayerClass) onChanged,
  }) =>
      PlayerClassList(
        includeCustom: includeCustom,
        includeDefault: includeDefault,
        builder: (context, list) => DropdownButton(
          isExpanded: true,
          value: list.firstWhere((cls) => cls.key == value.key,
              orElse: () => list.first),
          onChanged: onChanged,
          items: list
              .map((cls) => DropdownMenuItem(value: cls, child: Text(cls.name)))
              .toList(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var _dw = dungeonWorld.classes;
    var _custom = dwStore.state.customClasses.customClasses.values
        .map((cls) => cls.toPlayerClass());
    var combined = <PlayerClass>[
      if (includeDefault) ..._dw,
      if (includeCustom) ..._custom,
    ];
    return builder(context, combined);
  }
}
