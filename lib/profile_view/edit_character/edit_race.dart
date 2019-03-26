import 'package:dungeon_paper/components/title_subtitle_row.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';

class ChangeRaceDialog extends StatefulWidget {
  final PlayerClass playerClass;

  const ChangeRaceDialog({
    Key key,
    @required this.playerClass,
  }) : super(key: key);

  @override
  _ChangeRaceDialogState createState() => _ChangeRaceDialogState();
}

class _ChangeRaceDialogState extends State<ChangeRaceDialog> {
  ScrollController scrollController = ScrollController();
  double appBarElevation = 0.0;

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar:
          AppBar(
            title: Text('Choose Race'),
            elevation: appBarElevation,
          ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: widget.playerClass.raceMoves
                .map(
                  (move) => Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: RaceDescription(
                          playerClass: widget.playerClass,
                          race: move,
                          onTap: changeRace(move),
                        ),
                      ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Function() changeRace(Move def) {
    return () async {
      DbCharacter char = dwStore.state.characters.current;
      char.race = def;
      updateCharacter(char, [CharacterKeys.race]);
      Navigator.pop(context, true);
    };
  }

  void scrollListener() {
    double newElevation = scrollController.offset > 16.0 ? 1.0 : 0.0;
    if (newElevation != appBarElevation) {
      setState(() {
        appBarElevation = newElevation;
      });
    }
  }
}

class RaceDescription extends StatelessWidget {
  final void Function() onTap;
  final PlayerClass playerClass;
  final Move race;

  const RaceDescription({
    Key key,
    this.onTap,
    @required this.race,
    @required this.playerClass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleSubtitleCard(
      leading: Icon(Icons.pets, size: 40),
      title: Text(race.name),
      subtitle: Text(race.description),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
