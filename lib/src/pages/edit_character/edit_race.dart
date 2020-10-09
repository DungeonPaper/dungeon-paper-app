import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/atoms/card_list_item.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/utils/types.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class ChangeRaceDialog extends StatelessWidget {
  final Character character;
  final DialogMode mode;
  final VoidCallbackDelegate<Character> onUpdate;

  const ChangeRaceDialog({
    Key key,
    this.mode = DialogMode.Edit,
    @required this.character,
    @required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: character.mainClass.raceMoves
              .map(
                (move) => Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: RaceDescription(
                    playerClass: character.mainClass,
                    race: move,
                    onTap: changeRace(move),
                    color: Theme.of(context)
                        .canvasColor
                        .withOpacity(character.race == move ? 1 : 0.5),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Function() changeRace(Move def) {
    return () async {
      character.race = def;
      onUpdate?.call(character);
    };
  }
}

class RaceDescription extends StatelessWidget {
  final void Function() onTap;
  final PlayerClass playerClass;
  final Move race;
  final Color color;
  final double elevation;
  final EdgeInsets margin;

  const RaceDescription({
    Key key,
    this.onTap,
    @required this.race,
    @required this.playerClass,
    this.color,
    this.elevation,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardListItem(
      margin: margin,
      leading: Icon(Icons.pets, size: 40),
      title: Text(race.name),
      subtitle: Text(race.description),
      trailing: onTap != null ? Icon(Icons.chevron_right) : null,
      onTap: onTap,
      color: color,
      elevation: elevation,
    );
  }
}