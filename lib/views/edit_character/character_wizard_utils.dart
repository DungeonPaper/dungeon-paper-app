import 'package:dungeon_paper/db/character_utils.dart';
import 'package:dungeon_paper/refactor/character.dart';
import '../../components/confirmation_dialog.dart';
import '../../components/scaffold_with_elevation.dart';
import '../../components/dialogs.dart';
import 'package:flutter/material.dart';
import 'character_wizard_view.dart';

typedef ScaffoldBuilderFunction = Widget Function({
  @required BuildContext context,
  @required Widget child,
  @required void Function() save,
  @required bool Function() isValid,
  bool wrapWithScrollable,
});
typedef CharSaveFunction = void Function(
    Character char, List<CharacterKeys> keys);
enum WizardScaffoldButtonType { close, back }

Function() wrapOnDidPopHandler(
    BuildContext context, String text, Function() onPop) {
  return () async {
    bool res = await showDialog(
      context: context,
      builder: (ctx) => ConfirmationDialog(text: Text(text)),
    );
    if (res) {
      if (onPop == null) {
        Navigator.pop(context, false);
      } else {
        onPop();
      }
    }
  };
}

ScaffoldBuilderFunction characterWizardScaffold({
  DialogMode mode = DialogMode.Edit,
  @required String titleText,
  WizardScaffoldButtonType buttonType = WizardScaffoldButtonType.close,
  bool shouldPreventPop = true,
  Future<bool> Function() onWillPop,
  Function() onDidPop,
  String onLeaveText,
  String nextStepText,
}) {
  return ({
    @required BuildContext context,
    @required Widget child,
    @required void Function() save,
    @required bool Function() isValid,
    bool wrapWithScrollable = true,
  }) {
    var isEdit = mode == DialogMode.Edit;
    var onWillPopHandler = wrapOnDidPopHandler(
      context,
      onLeaveText != null
          ? onLeaveText
          : isEdit
              ? "If you leave this screen now, your changes won't be saved."
              : "If you go back, changes made on this screen will not be saved.",
      onDidPop,
    );
    var finalOnWillPop =
        shouldPreventPop ? onWillPop ?? onWillPopHandler : null;
    return WillPopScope(
      onWillPop: finalOnWillPop,
      child: ScaffoldWithElevation.primaryBackground(
        wrapWithScrollable: wrapWithScrollable,
        title: Text(titleText),
        actions: save != null
            ? [
                GenericAppBarActionButton(
                  child: Text(nextStepText != null
                      ? nextStepText
                      : isEdit ? 'Save' : 'Next Step'),
                  onPressed: isValid != null ? isValid() ? save : null : null,
                ),
              ]
            : null,
        automaticallyImplyLeading: false,
        appBarLeading: IconButton(
          icon: Icon(
            buttonType == WizardScaffoldButtonType.close
                ? Icons.close
                : Icons.arrow_back,
          ),
          onPressed: finalOnWillPop,
        ),
        child: child,
      ),
    );
  };
}
