import '../../db/character.dart';
import '../../db/character_types.dart' as Chr;
import '../../dialogs.dart';
import '../../profile_view/edit_character/alignment_description_card.dart';
import '../../profile_view/edit_character/character_wizard_utils.dart';
import 'package:flutter/material.dart';

class ChangeAlignmentDialog extends StatelessWidget {
  final DialogMode mode;
  final CharSaveFunction onSave;
  final ScaffoldBuilderFunction builder;
  final DbCharacter character;

  const ChangeAlignmentDialog({
    Key key,
    @required this.character,
    @required this.onSave,
    this.mode = DialogMode.Edit,
    this.builder,
  }) : super(key: key);

  ChangeAlignmentDialog.withScaffold({
    Key key,
    @required this.character,
    @required this.onSave,
    this.mode = DialogMode.Edit,
    Function() onDidPop,
    Function() onWillPop,
  })  : builder = characterWizardScaffold(
          mode: mode,
          titleText: 'Alignment',
          buttonType: WizardScaffoldButtonType.back,
          onDidPop: onDidPop,
          onWillPop: onWillPop,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: Chr.Alignment.values
            .map(
              (alignment) => Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: AlignmentDescription(
                  playerClass: character.mainClass,
                  alignment: alignment,
                  onTap: changeAlignment(alignment),
                ),
              ),
            )
            .toList(),
      ),
    );
    if (builder != null) {
      return builder(context, child, null, null);
    }
    return child;
  }

  Function() changeAlignment(Chr.Alignment def) {
    return () async {
      character.alignment = def;
      onSave(character, [CharacterKeys.alignment]);
    };
  }
}
