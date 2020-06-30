import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/molecules/edit_avatar_card.dart';
import 'package:dungeon_paper/src/utils/types.dart';
import 'edit_display_name_card.dart';
import 'package:flutter/material.dart';

class EditBasicInfoView extends StatefulWidget {
  final Character character;
  final VoidCallbackDelegate<Character> onUpdate;
  final DialogMode mode;
  final ValueNotifier validityNotifier;

  const EditBasicInfoView({
    Key key,
    @required this.onUpdate,
    this.mode = DialogMode.Edit,
    this.character,
    this.validityNotifier,
  }) : super(key: key);

  @override
  _EditBasicInfoViewState createState() => _EditBasicInfoViewState();
}

enum Keys { displayName, photoURL }

class _EditBasicInfoViewState extends State<EditBasicInfoView> {
  static Widget spacer = SizedBox(height: 10.0);
  Map<Keys, TextEditingController> editingControllers;

  @override
  void initState() {
    editingControllers = WidgetUtils.textEditingControllerMap(list: [
      EditingControllerConfig(
        key: Keys.displayName,
        defaultValue: widget.character.displayName,
        listener: () {
          var def = widget.character;
          def.displayName = editingControllers[Keys.displayName].text.trim();
          updateWith(def);
        },
      ),
      EditingControllerConfig(
        key: Keys.photoURL,
        defaultValue: widget.character.photoURL,
        listener: () {
          var def = widget.character;
          def.photoURL = editingControllers[Keys.photoURL].text.trim();
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
                controller: editingControllers[Keys.displayName]),
            spacer,
            EditAvatarCard(controller: editingControllers[Keys.photoURL]),
          ],
        ),
      ),
    );
  }

  bool _isValid() => editingControllers[Keys.displayName].text.isNotEmpty;

  void updateWith(Character def) {
    widget.validityNotifier?.value = _isValid();
    widget?.onUpdate?.call(def);
  }
}
