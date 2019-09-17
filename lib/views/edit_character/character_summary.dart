import 'package:dungeon_paper/components/title_subtitle_row.dart';
import 'package:dungeon_paper/views/basic_info/character_photo.dart';
import 'package:dungeon_paper/views/battle_view/move_card.dart';
import '../../utils.dart';
import '../../views/profile_view/character_headline.dart';
import '../../views/stats/stats_summary.dart';
import '../../db/character.dart';
import '../../components/dialogs.dart';
import 'character_wizard_utils.dart';
import 'package:flutter/material.dart';
import '../../db/character_utils.dart' as Chr;
import 'edit_looks.dart';
import 'edit_race.dart';

class CharacterSummary extends StatelessWidget {
  final DbCharacter character;
  final CharSaveFunction onSave;
  final ScaffoldBuilderFunction builder;

  CharacterSummary({
    Key key,
    @required this.character,
    @required this.onSave,
    this.builder,
  }) : super(key: key);

  CharacterSummary.withScaffold({
    Key key,
    @required this.character,
    @required this.onSave,
    Function() onDidPop,
    Function() onWillPop,
    bool shouldPreventPop = true,
  })  : builder = characterWizardScaffold(
          mode: DialogMode.Create,
          titleText: 'Summary',
          nextStepText: 'Finish',
          onDidPop: onDidPop,
          onWillPop: onWillPop,
          shouldPreventPop: shouldPreventPop,
          buttonType: WizardScaffoldButtonType.back,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var child = Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        // color: Colors.red,
        child: Column(
          children: <Widget>[
            if (character.photoURL != null)
              CharacterPhoto(character: character),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CharacterHeadline(
                character: character,
                editable: false,
              ),
            ),
            StatsSummary(character: character),
            singleChildRow(
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0, top: 8),
                child: ClassSummary(character: character),
              ),
            ),
            singleChildRow(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: AlignmentSummary(character: character),
              ),
            ),
            singleChildRow(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RaceSummary(character: character),
              ),
            ),
            singleChildRow(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: LooksSummary(character: character),
              ),
            ),
          ],
        ),
      ),
    );
    if (builder != null) {
      return builder(
        context: context,
        child: child,
        save: () => onSave(character, []),
        isValid: () => true,
      );
    }
    return child;
  }

  Widget singleChildRow(Widget child) {
    return Row(children: [Expanded(child: child)]);
  }
}

class AlignmentSummary extends StatelessWidget {
  final DbCharacter character;

  AlignmentSummary({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alignment = character.mainClass.alignments[alignmentKey];
    return TitleSubtitleCard(
      elevation: 0.0,
      margin: EdgeInsets.all(0),
      color: Theme.of(context).canvasColor.withOpacity(0.5),
      leading: Icon(icon, size: 40),
      title: Text(alignment.name),
      subtitle: Text(alignment.description),
    );
  }

  String get alignmentKey => enumName(character.alignment);
  get icon => Chr.ALIGNMENT_ICON_MAP[character.alignment];
}

class RaceSummary extends StatelessWidget {
  final DbCharacter character;

  RaceSummary({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaceDescription(
      race: character.race,
      playerClass: character.mainClass,
      color: Theme.of(context).canvasColor.withOpacity(0.5),
      elevation: 0,
      margin: EdgeInsets.all(0),
    );
  }

  String get alignmentKey => enumName(character.alignment);
  get icon => Chr.ALIGNMENT_ICON_MAP[character.alignment];
}

class ClassSummary extends StatelessWidget {
  final DbCharacter character;

  ClassSummary({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleSubtitleCard(
      title: Text(character.mainClass.name),
      subtitle: Text(
        character.mainClass.description,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Icon(Icons.person, size: 40.0),
      color: Theme.of(context).canvasColor.withOpacity(0.5),
      elevation: 0,
      margin: EdgeInsets.all(0),
    );
  }

  String get alignmentKey => enumName(character.alignment);
  get icon => Chr.ALIGNMENT_ICON_MAP[character.alignment];
}

class LooksSummary extends StatelessWidget {
  final DbCharacter character;

  LooksSummary({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LooksDescription(
      playerClass: character.mainClass,
      looks: character.looks,
      color: Theme.of(context).canvasColor.withOpacity(0.5),
      elevation: 0,
      margin: EdgeInsets.all(0),
    );
  }

  String get alignmentKey => enumName(character.alignment);
  get icon => Chr.ALIGNMENT_ICON_MAP[character.alignment];
}
