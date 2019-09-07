import 'package:dungeon_paper/db/character_utils.dart';
import '../../components/title_subtitle_row.dart';
import '../../db/character.dart';
import '../../components/dialogs.dart';
import 'character_wizard_utils.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class ChangeRaceDialog extends StatelessWidget {
  final DbCharacter character;
  final DialogMode mode;
  final CharSaveFunction onSave;
  final ScaffoldBuilderFunction builder;

  const ChangeRaceDialog({
    Key key,
    this.mode = DialogMode.Edit,
    @required this.character,
    @required this.onSave,
    this.builder,
  }) : super(key: key);

  ChangeRaceDialog.withScaffold({
    Key key,
    this.mode = DialogMode.Edit,
    @required this.character,
    @required this.onSave,
    Function() onDidPop,
    Function() onWillPop,
  })  : builder = characterWizardScaffold(
          mode: mode,
          titleText: 'Choose Race',
          onDidPop: onDidPop,
          onWillPop: onWillPop,
          buttonType: WizardScaffoldButtonType.back,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Padding(
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
                ),
              ),
            )
            .toList(),
      ),
    );
    if (builder != null) {
      return builder(context: context, child: child, save: null, isValid: null);
    }
    return child;
  }

  Function() changeRace(Move def) {
    return () async {
      character.race = def;
      onSave(character, [CharacterKeys.race]);
    };
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
