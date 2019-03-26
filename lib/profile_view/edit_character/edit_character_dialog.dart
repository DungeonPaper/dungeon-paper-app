import 'package:dungeon_paper/components/animations/slide_route_from_right.dart';
import 'package:dungeon_paper/components/class_description.dart';
import 'package:dungeon_paper/components/confirmation_dialog.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/profile_view/basic_info/change_alignment_dialog.dart';
import 'package:dungeon_paper/profile_view/basic_info/change_class_dialog.dart';
import 'package:dungeon_paper/profile_view/edit_character/alignment_description_card.dart';
import 'package:dungeon_paper/profile_view/edit_character/edit_avatar_card.dart';
import 'package:dungeon_paper/profile_view/edit_character/edit_display_name_card.dart';
import 'package:dungeon_paper/profile_view/edit_character/edit_looks.dart';
import 'package:dungeon_paper/profile_view/edit_character/edit_race.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:flutter/material.dart';

class EditCharacterDialog extends StatefulWidget {
  final DbCharacter character;

  const EditCharacterDialog({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  _EditCharacterDialogState createState() => _EditCharacterDialogState();
}

class _EditCharacterDialogState extends State<EditCharacterDialog> {
  String photoURL;
  String displayName;
  TextEditingController photoURLController;
  TextEditingController displayNameController;
  static Widget spacer = SizedBox(height: 10.0);
  ScrollController scrollController = ScrollController();
  double appBarElevation = 0.0;

  @override
  void initState() {
    photoURL = widget.character.photoURL ?? '';
    displayName = widget.character.displayName ?? '';

    scrollController.addListener(scrollListener);

    photoURLController =
        TextEditingController.fromValue(TextEditingValue(text: photoURL))
          ..addListener(photoURLListener);

    displayNameController =
        TextEditingController.fromValue(TextEditingValue(text: displayName))
          ..addListener(displayNameListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    photoURLController.removeListener(photoURLListener);
    displayNameController.removeListener(displayNameListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Edit Character Details'),
        elevation: appBarElevation,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).canvasColor,
              onPressed: formValid() ? save : null,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    EditDisplayNameCard(controller: displayNameController),
                    spacer,
                    EditAvatarCard(controller: photoURLController),
                    spacer,
                    ClassSmallDescription(
                        playerClass: widget.character.mainClass,
                        level: widget.character.level,
                        onTap: () => changeClass(context)),
                    spacer,
                    AlignmentDescription(
                        playerClass: widget.character.mainClass,
                        alignment: widget.character.alignment,
                        onTap: () => changeAlignment(context)),
                    spacer,
                    RaceDescription(
                      playerClass: widget.character.mainClass,
                      race: widget.character.race ??
                          widget.character.mainClass.raceMoves.first,
                      onTap: () => changeRace(context),
                    ),
                    spacer,
                    LooksDescription(
                      playerClass: widget.character.mainClass,
                      looks: widget.character.looks,
                      onTap: () => changeLooks(context),
                    ),
                    spacer,
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        // color: Colors.red,
                        textColor: Colors.red,
                        child: Text('Delete Character'),
                        onPressed:
                            dwStore.state.characters.characters.isNotEmpty
                                ? _deleteCharacter
                                : null,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool formValid() {
    return <bool>[
      displayName != null && displayName.length > 0,
    ].every((cond) => cond);
  }

  _deleteCharacter() async {
    if (await showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
            title: Text('Delete Character?'),
            text: Text(
                'THIS CAN NOT BE UNDONE!\nAre you sure this is what you want to do?'),
            okButtonText: Text('I WANT THIS CHARACTER GONE!'),
            cancelButtonText: Text('I regret clicking this'),
          ),
    )) {
      deleteCharacter();
      await Future.delayed(Duration(milliseconds: 1000));
      Navigator.pop(context);
    }
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

  void changeClass(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim, anim2) => ChangeClassDialog(),
        transitionsBuilder: (context, inAnim, outAnim, child) {
          return SlideRouteFromRight(
            inAnim: inAnim,
            outAnim: outAnim,
            child: ChangeClassDialog(),
          );
        },
      ),
    );
  }

  void changeAlignment(BuildContext context) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim, anim2) => ChangeAlignmentDialog(
              playerClass: widget.character.mainClass,
            ),
        transitionsBuilder: (context, inAnim, outAnim, child) {
          return SlideRouteFromRight(
            inAnim: inAnim,
            outAnim: outAnim,
            child: ChangeAlignmentDialog(
              playerClass: widget.character.mainClass,
            ),
          );
        },
      ),
    );
  }

  void changeRace(BuildContext context) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim, anim2) => ChangeRaceDialog(
              playerClass: widget.character.mainClass,
            ),
        transitionsBuilder: (context, inAnim, outAnim, child) {
          return SlideRouteFromRight(
            inAnim: inAnim,
            outAnim: outAnim,
            child: ChangeRaceDialog(
              playerClass: widget.character.mainClass,
            ),
          );
        },
      ),
    );
  }

  void changeLooks(BuildContext context) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim, anim2) => ChangeLooksDialog(
              playerClass: widget.character.mainClass,
              looks: widget.character.looks,
            ),
        transitionsBuilder: (context, inAnim, outAnim, child) {
          return SlideRouteFromRight(
            inAnim: inAnim,
            outAnim: outAnim,
            child: ChangeLooksDialog(
              playerClass: widget.character.mainClass,
              looks: widget.character.looks,
            ),
          );
        },
      ),
    );
  }

  void displayNameListener() {
    setState(() {
      displayName = displayNameController.text;
    });
  }

  void photoURLListener() {
    setState(() {
      photoURL = photoURLController.text;
    });
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
