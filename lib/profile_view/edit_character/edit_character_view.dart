import 'package:dungeon_paper/components/animations/slide_route_from_right.dart';
import 'package:dungeon_paper/components/card_list_item.dart';
import 'package:dungeon_paper/components/confirmation_dialog.dart';
import 'package:dungeon_paper/components/scaffold_with_elevation.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/character_db.dart';
import 'package:dungeon_paper/db/character_utils.dart' as Chr;
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_paper/profile_view/basic_info/change_alignment_dialog.dart';
import 'package:dungeon_paper/profile_view/class_selection/change_class_dialog.dart';
import 'package:dungeon_paper/profile_view/edit_character/alignment_description_card.dart';
import 'package:dungeon_paper/profile_view/edit_character/edit_looks.dart';
import 'package:dungeon_paper/profile_view/edit_character/edit_race.dart';
import 'package:dungeon_paper/profile_view/edit_character/edit_basic_info_view.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:flutter/material.dart';

class EditCharacterView extends StatefulWidget {
  final DbCharacter character;

  const EditCharacterView({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  _EditCharacterViewState createState() => _EditCharacterViewState();
}

class _EditCharacterViewState extends State<EditCharacterView> {
  static Widget spacer = SizedBox(height: 10.0);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithElevation.primaryBackground(
      title: Text('Edit Character Details'),
      automaticallyImplyLeading: true,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CardListItem(
              title: Text('Basic Info'),
              subtitle: Text('Character name and avatar URL'),
              leading: Padding(
                padding: EdgeInsets.only(left: 5.0, right: 21.0),
                child: Icon(Icons.speaker_notes, size: 30.0),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () => animatedScreen(
                context,
                EditBasicInfoView.withScaffold(
                  mode: DialogMode.Edit,
                  character: widget.character,
                  onSave: _updateCharacter(context),
                ),
              ),
            ),
            spacer,
            CardListItem(
              title: Text(
                (widget.character.level != null
                        ? "Level ${widget.character.level} "
                        : "") +
                    widget.character.mainClass.name,
              ),
              subtitle: Text('Change class'),
              leading: Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.person, size: 40.0),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () => animatedScreen(
                context,
                ClassSelectionScreen.withScaffold(
                  character: widget.character,
                  onSave: _updateCharacter(context),
                ),
              ),
            ),
            spacer,
            AlignmentDescription(
              playerClass: widget.character.mainClass,
              alignment: widget.character.alignment,
              onTap: () => animatedScreen(
                context,
                ChangeAlignmentDialog.withScaffold(
                  character: widget.character,
                  onSave: _updateCharacter(context),
                ),
              ),
            ),
            spacer,
            RaceDescription(
              playerClass: widget.character.mainClass,
              race: widget.character.race ??
                  widget.character.mainClass.raceMoves.first,
              onTap: () => animatedScreen(
                context,
                ChangeRaceDialog.withScaffold(
                  onSave: _updateCharacter(context),
                  character: widget.character,
                ),
              ),
            ),
            spacer,
            LooksDescription(
              playerClass: widget.character.mainClass,
              looks: widget.character.looks,
              onTap: () => animatedScreen(
                context,
                ChangeLooksDialog.withScaffold(
                  character: widget.character,
                  onSave: _updateCharacter(context),
                ),
              ),
            ),
            spacer,
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                // color: Colors.red,
                textColor: Colors.red,
                child: Text('Delete Character'),
                onPressed: dwStore.state.characters.characters.isNotEmpty
                    ? _deleteCharacter
                    : null,
              ),
            )
          ],
        ),
      ),
    );
  }

  _deleteCharacter() async {
    if (dwStore.state.characters.characters.length == 1)
      return showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
          title: Text('Uhh, wait!'),
          text: Text(
              "You can't delete your last character.\n\nIf you want to start fresh, create another empty character first."),
          noCancel: true,
        ),
      );
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

  void animatedScreen(BuildContext context, Widget child) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim, anim2) => child,
        transitionsBuilder: (context, inAnim, outAnim, child) {
          return SlideRouteFromRight(
            inAnim: inAnim,
            outAnim: outAnim,
            child: child,
          );
        },
      ),
    );
  }

  void Function(DbCharacter char, List<Chr.CharacterKeys> keys) _updateCharacter(
      BuildContext context) {
    return (DbCharacter char, List<Chr.CharacterKeys> keys) {
      updateCharacter(char, keys);
      if (context != null) {
        Navigator.pop(context);
      }
    };
  }
}
