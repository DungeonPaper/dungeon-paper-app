import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_paper/profile_view/basic_info/profile_view.dart';
import 'package:dungeon_paper/profile_view/edit_character/character_wizard_utils.dart';
import 'package:flutter/material.dart';

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
  })  : builder = characterWizardScaffold(
          mode: DialogMode.Create,
          titleText: 'Summary',
          nextStepText: 'Finish',
          onDidPop: onDidPop,
          onWillPop: onWillPop,
          buttonType: WizardScaffoldButtonType.back,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var child = Column(
      children: <Widget>[
        CharacterHeader(
          character: character,
          editable: false,
        ),
      ],
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
}
