import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/molecules/edit_avatar_card.dart';
import 'package:dungeon_paper/src/pages/edit_character/edit_bio_card.dart';
import 'package:dungeon_paper/src/pages/edit_character/edit_display_name_card.dart';
import 'package:dungeon_paper/src/utils/types.dart';
import 'package:flutter/material.dart';

class EditBasicInfoView extends StatefulWidget {
  final Character character;
  final VoidCallbackDelegate<Character> onUpdate;
  final DialogMode mode;
  final ValueNotifier validityNotifier;

  const EditBasicInfoView({
    Key key,
    @required this.onUpdate,
    this.mode = DialogMode.edit,
    this.character,
    this.validityNotifier,
  }) : super(key: key);

  @override
  _EditBasicInfoViewState createState() => _EditBasicInfoViewState();
}

enum _Keys { displayName, photoURL, bio }

class _EditBasicInfoViewState extends State<EditBasicInfoView> {
  static Widget spacer = SizedBox(height: 10.0);
  Map<_Keys, TextEditingController> editingControllers;

  @override
  void initState() {
    editingControllers = WidgetUtils.textEditingControllerMap(list: [
      EditingControllerConfig(
        key: _Keys.displayName,
        defaultValue: widget.character.displayName,
        listener: () {
          var def = widget.character.copyWith(
            displayName: editingControllers[_Keys.displayName].text.trim(),
          );
          updateWith(def);
        },
      ),
      EditingControllerConfig(
        key: _Keys.photoURL,
        defaultValue: widget.character.photoURL,
        listener: () {
          var def = widget.character.copyWith(
            photoURL: editingControllers[_Keys.photoURL].text.trim(),
          );
          updateWith(def);
        },
      ),
      EditingControllerConfig(
        key: _Keys.bio,
        defaultValue: widget.character.bio,
        listener: () {
          var def = widget.character.copyWith(
            bio: editingControllers[_Keys.bio].text.trim(),
          );
          updateWith(def);
        },
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EditDisplayNameCard(
              controller: editingControllers[_Keys.displayName],
            ),
            spacer,
            EditAvatarCard(
              character: widget.character,
              controller: editingControllers[_Keys.photoURL],
              onSave: (char) {
                updateWith(
                  widget.character.copyWith(
                    settings: char.settings,
                  ),
                );
              },
            ),
            spacer,
            EditBioCard(
              controller: editingControllers[_Keys.bio],
            ),
          ],
        ),
      ),
    );
  }

  bool _isValid() => editingControllers[_Keys.displayName].text.isNotEmpty;

  void updateWith(Character def) {
    widget.validityNotifier?.value = _isValid();
    widget?.onUpdate?.call(def);
  }
}
