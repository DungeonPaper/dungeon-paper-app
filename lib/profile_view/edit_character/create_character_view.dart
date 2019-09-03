import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/character_db.dart';
import 'package:dungeon_paper/profile_view/basic_info/change_alignment_dialog.dart';
import 'package:dungeon_paper/profile_view/class_selection/change_class_dialog.dart';
import 'package:dungeon_paper/profile_view/edit_character/character_summary.dart';
import 'package:dungeon_paper/profile_view/edit_character/edit_basic_info_view.dart';
import 'package:dungeon_paper/profile_view/edit_character/edit_race.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../dialogs.dart';
import 'edit_looks.dart';

enum CreateCharacterStep { BasicInfo, MainClass, Alignment, Race, Looks, Summary }

class CreateCharacterView extends StatefulWidget {
  @override
  _CreateCharacterViewState createState() => _CreateCharacterViewState();
}

class _CreateCharacterViewState extends State<CreateCharacterView> {
  DbCharacter character = DbCharacter();
  CreateCharacterStep step = CreateCharacterStep.BasicInfo;

  @override
  Widget build(BuildContext context) {
    return getCorrectView(
      context: context,
    );
  }

  Widget getCorrectView({BuildContext context}) {
    switch (step) {
      case CreateCharacterStep.Summary:
        return CharacterSummary.withScaffold(
          character: character,
          onSave: _copyCharAndProceed,
          onDidPop: _prevStep,
        );
      case CreateCharacterStep.Looks:
        return ChangeLooksDialog.withScaffold(
          character: character,
          mode: DialogMode.Create,
          onSave: _copyCharAndProceed,
          onDidPop: _prevStep,
        );
      case CreateCharacterStep.Race:
        return ChangeRaceDialog.withScaffold(
          character: character,
          mode: DialogMode.Create,
          onSave: _copyCharAndProceed,
          onDidPop: _prevStep,
        );
      case CreateCharacterStep.Alignment:
        return ChangeAlignmentDialog.withScaffold(
          character: character,
          mode: DialogMode.Create,
          onSave: _copyCharAndProceed,
          onDidPop: _prevStep,
        );
      case CreateCharacterStep.MainClass:
        return ClassSelectionScreen.withScaffold(
          character: character,
          mode: DialogMode.Create,
          onSave: _copyCharAndProceed,
          onDidPop: _prevStep,
        );
      case CreateCharacterStep.BasicInfo:
      default:
        return EditBasicInfoView.withScaffold(
          character: character,
          mode: DialogMode.Create,
          onSave: _copyCharAndProceed,
          onLeaveText: "Leaving this screen will discard any selections you made and cancel the character creation.",
        );
    }
  }

  void _copyCharAndProceed(char, _ks) {
    setState(() {
      character = char;
      _nextStep();
    });
  }

  void _prevStep() {
    num stepIdx = CreateCharacterStep.values.indexOf(step);
    if (stepIdx == 0) {
      return;
    }
    setState(() {
      step = CreateCharacterStep.values[--stepIdx];
    });
  }

  void _nextStep() async {
    num stepIdx = CreateCharacterStep.values.indexOf(step);
    stepIdx++;
    if (stepIdx >= CreateCharacterStep.values.length) {
      await createNewCharacter(character);
      Navigator.pop(context);
    } else {
      setState(() {
        step = CreateCharacterStep.values[stepIdx];
      });
    }
  }
}

class GenericAppBarActionButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;

  const GenericAppBarActionButton({
    Key key,
    @required this.child,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(left: 4.0),
      child: RaisedButton(
        child: child,
        color: Theme.of(context).canvasColor,
        onPressed: onPressed,
      ),
    );
  }
}
