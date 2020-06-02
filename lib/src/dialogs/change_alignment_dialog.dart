import 'package:dungeon_paper/db/helpers/character_utils.dart' as chr;
import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/atoms/alignment_description_card.dart';
import 'package:dungeon_paper/src/pages/character_wizard/character_wizard_utils.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';

class ChangeAlignmentDialog extends StatelessWidget {
  final DialogMode mode;
  final CharSaveFunction onSave;
  final ScaffoldBuilderFunction builder;
  final Character character;

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
        children: chr.AlignmentName.values
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
      return builder(context: context, child: child, save: null, isValid: null);
    }
    return child;
  }

  Function() changeAlignment(chr.AlignmentName def) {
    return () async {
      onSave({'alignment': enumName(def)});
    };
  }
}
