import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/profile_view/edit_character/edit_avatar_card.dart';
import 'package:dungeon_paper/profile_view/edit_character/edit_display_name_card.dart';
import 'package:flutter/material.dart';

class UpdateBasicInfoView extends StatefulWidget {
  final DbCharacter character;

  const UpdateBasicInfoView({
    Key key,
    this.character,
  }) : super(key: key);

  @override
  _UpdateBasicInfoViewState createState() => _UpdateBasicInfoViewState();
}

class _UpdateBasicInfoViewState extends State<UpdateBasicInfoView> {
  static Widget spacer = SizedBox(height: 10.0);

  ScrollController scrollController = ScrollController();
  double appBarElevation = 0.0;
  String photoURL;
  String displayName;
  TextEditingController photoURLController;
  TextEditingController displayNameController;
  bool dirty = false;

  void displayNameListener() {
    setState(() {
      dirty = true;
      displayName = displayNameController.text;
    });
  }

  void photoURLListener() {
    setState(() {
      dirty = true;
      photoURL = photoURLController.text;
    });
  }

  @override
  void dispose() {
    photoURLController.removeListener(photoURLListener);
    displayNameController.removeListener(displayNameListener);
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

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
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Basic Information'),
        elevation: appBarElevation,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(left: 4.0),
            child: RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).canvasColor,
              onPressed: formValid() ? save : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              EditDisplayNameCard(controller: displayNameController),
              spacer,
              EditAvatarCard(controller: photoURLController),
            ],
          ),
        ),
      ),
    );
  }

  bool formValid() {
    return dirty &&
        <bool>[
          displayName != null && displayName.length > 0,
        ].every((cond) => cond);
  }

  void save() {
    DbCharacter character = widget.character;
    character.displayName = displayName;
    character.photoURL = photoURL;
    updateCharacter(
      character,
      [CharacterKeys.displayName, CharacterKeys.photoURL],
    );
    Navigator.pop(context);
  }

  void scrollListener() {
    double newElevation = scrollController.offset > 16.0 ? 1.0 : 0.0;
    if (newElevation != appBarElevation) {
      setState(() {
        appBarElevation = newElevation;
      });
    }
  }
}
