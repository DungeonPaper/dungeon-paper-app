import '../../db/character.dart';
import '../../components/confirmation_dialog.dart';
import '../../components/scaffold_with_elevation.dart';
import '../../dialogs.dart';
import 'package:flutter/material.dart';
import 'create_character_view.dart';

typedef ScaffoldBuilderFunction = Widget Function(BuildContext context,
    Widget child, void Function() save, bool Function() isValid);
typedef CharSaveFunction = void Function(
    DbCharacter char, List<CharacterKeys> keys);
enum WizardScaffoldButtonType { close, back }

Function() wrapOnDidPopHandler(
    BuildContext context, String text, Function() onPop) {
  return () async {
    bool res = await showDialog(
      context: context,
      builder: (ctx) => ConfirmationDialog(text: Text(text)),
    );
    if (res) {
      if (onPop == null)
        Navigator.pop(context, false);
      else
        onPop();
    }
  };
}

characterWizardScaffold({
  DialogMode mode = DialogMode.Edit,
  @required String titleText,
  WizardScaffoldButtonType buttonType = WizardScaffoldButtonType.close,
  bool shouldPreventPop = true,
  Future<bool> Function() onWillPop,
  Function() onDidPop,
  String onLeaveText,
}) {
  return (BuildContext context, Widget child, void Function() save,
      bool Function() isValid) {
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
    return WillPopScope(
      onWillPop: shouldPreventPop ? onWillPop ?? onWillPopHandler : null,
      child: ScaffoldWithElevation.primaryBackground(
        title: Text(titleText),
        actions: save != null
            ? [
                GenericAppBarActionButton(
                  child: Text(isEdit ? 'Save' : 'Next Step'),
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
          onPressed: onWillPopHandler,
        ),
        child: child,
      ),
    );
  };
}
