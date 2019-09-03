import 'package:dungeon_paper/db/character_utils.dart';

import '../../db/character.dart';
import '../../dialogs.dart';
import '../../profile_view/edit_character/edit_avatar_card.dart';
import '../../profile_view/edit_character/edit_display_name_card.dart';
import 'package:flutter/material.dart';
import 'character_wizard_utils.dart';

class EditBasicInfoView extends StatefulWidget {
  final DbCharacter character;
  final CharSaveFunction onSave;
  final DialogMode mode;
  final ScaffoldBuilderFunction builder;

  const EditBasicInfoView({
    Key key,
    @required this.onSave,
    this.mode = DialogMode.Edit,
    this.character,
    this.builder,
  }) : super(key: key);

  EditBasicInfoView.withScaffold({
    Key key,
    @required this.onSave,
    this.mode = DialogMode.Edit,
    this.character,
    Function() onDidPop,
    Function() onWillPop,
    String onLeaveText,
  })  : builder = characterWizardScaffold(
          mode: mode,
          titleText: 'Basic Information',
          buttonType: mode == DialogMode.Edit
              ? WizardScaffoldButtonType.back
              : WizardScaffoldButtonType.close,
          onDidPop: onDidPop,
          onWillPop: onWillPop,
          onLeaveText: onLeaveText,
        ),
        super(key: key);

  @override
  _EditBasicInfoViewState createState() => _EditBasicInfoViewState();
}

class _EditBasicInfoViewState extends State<EditBasicInfoView> {
  static Widget spacer = SizedBox(height: 10.0);

  String photoURL;
  String displayName;
  TextEditingController photoURLController;
  TextEditingController displayNameController;
  bool dirty;

  @override
  void initState() {
    photoURL = widget.character.photoURL ?? '';
    displayName = widget.character.displayName ?? '';

    photoURLController =
        TextEditingController.fromValue(TextEditingValue(text: photoURL))
          ..addListener(photoURLListener);

    displayNameController =
        TextEditingController.fromValue(TextEditingValue(text: displayName))
          ..addListener(displayNameListener);
    dirty = false;
    super.initState();
  }

  @override
  void dispose() {
    photoURLController.removeListener(photoURLListener);
    displayNameController.removeListener(displayNameListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var child = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          EditDisplayNameCard(controller: displayNameController),
          spacer,
          EditAvatarCard(controller: photoURLController),
        ],
      ),
    );
    if (widget.builder != null) {
      return widget.builder(
          context: context, child: child, save: save, isValid: formValid);
    }
    return child;
  }

  bool formValid() {
    return dirty &&
        <bool>[
          displayName != null && displayName.length > 0,
        ].every((cond) => cond);
  }

  void save() {
    if (widget.onSave != null) {
      DbCharacter character = widget.character;
      character.displayName = displayName;
      character.photoURL = photoURL;
      widget.onSave(character, [
        CharacterKeys.displayName,
        CharacterKeys.photoURL,
      ]);
    }
  }

  void displayNameListener() {
    setState(() {
      // dirty = displayName != displayNameController.text;
      dirty = true;
      displayName = displayNameController.text;
    });
  }

  void photoURLListener() {
    setState(() {
      // dirty = photoURL != photoURLController.text;
      dirty = true;
      photoURL = photoURLController.text;
    });
  }
}
