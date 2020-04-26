import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/character.dart';
import '../basic_info/change_alignment_dialog.dart';
import '../profile_view/class_selection/class_selection_screen.dart';
import '../stats/edit_stats.dart';
import '../../widget_utils.dart';
import '../../components/dialogs.dart';
import 'character_summary.dart';
import 'edit_basic_info_view.dart';
import 'edit_race.dart';
import 'edit_looks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum CreateCharacterStep {
  BasicInfo,
  MainClass,
  Alignment,
  Race,
  Looks,
  Stats,
  Summary,
  Finishing
}

class CharacterWizardView extends StatefulWidget {
  @override
  _CharacterWizardViewState createState() => _CharacterWizardViewState();
}

class _CharacterWizardViewState extends State<CharacterWizardView> {
  Character character = Character();
  CreateCharacterStep step = CreateCharacterStep.BasicInfo;

  @override
  Widget build(BuildContext context) {
    return getCorrectView(
      context: context,
    );
  }

  Widget getCorrectView({BuildContext context}) {
    switch (step) {
      case CreateCharacterStep.Finishing:
        return Container(
          color: Theme.of(context).primaryColor,
          child: Center(
            child: PageLoader(),
          ),
        );
      case CreateCharacterStep.Summary:
        return CharacterSummary.withScaffold(
          character: character,
          onSave: _copyCharAndProceed,
          onWillPop: _prevStep,
        );
      case CreateCharacterStep.Stats:
        return EditStats.withScaffold(
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
          onLeaveText:
              "Leaving this screen will discard any selections you made and cancel the character creation.",
        );
    }
  }

  void _copyCharAndProceed(_ks) async {
    await character.update(json: _ks, save: false);
    setState(() {
      _nextStep();
    });
  }

  Future<bool> _prevStep() async {
    num stepIdx = CreateCharacterStep.values.indexOf(step);
    if (stepIdx == 0) {
      return true;
    }
    setState(() {
      step = CreateCharacterStep.values[--stepIdx];
    });
    return false;
  }

  void _nextStep() async {
    num stepIdx = CreateCharacterStep.values.indexOf(step);
    if (stepIdx >= CreateCharacterStep.values.length - 2) {
      setState(() {
        step = CreateCharacterStep.Finishing;
      });
      var user = dwStore.state.user.current;
      await user.createCharacter(character);
      Navigator.pop(context);
    } else {
      stepIdx++;
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
