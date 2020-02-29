import 'package:dungeon_paper/components/dialogs.dart';
import 'package:dungeon_paper/refactor/auth.dart' as auth;
import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_paper/refactor/user.dart';
import 'package:dungeon_paper/views/custom_classes/edit_custom_class.dart';
import 'package:dungeon_paper/views/whats_new/whats_new_view.dart';
import '../about_view/about_view.dart';
import '../about_view/feedback_button.dart';
import '../edit_character/character_wizard_view.dart';
import '../../redux/actions.dart';
import '../../redux/stores/connectors.dart';
import '../../redux/stores/stores.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DWStoreConnector<DWStore>(
      builder: (context, state) {
        User user = state.user.current;
        List<Widget> items = [
              UserAccountsDrawerHeader(
                accountEmail: Text(user.email),
                accountName: Text(user.displayName),
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(user.photoURL),
                    ),
                  ),
                ),
              ),
              title('Characters', context),
            ] +
            characterList(state.characters.characters, context) +
            [
              Divider(),
              // Create Empty Character
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Create Empty Character'),
                onTap: () {
                  Navigator.pop(context);
                  createNewCharacterScreen(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Create New Class'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute<bool>(
                      fullscreenDialog: true,
                      builder: (context) => EditCustomClass(
                        mode: DialogMode.Create,
                      ),
                    ),
                  );
                },
              ),
              Divider(),
              title('Application', context),
              // About
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => AboutView(),
                    ),
                  );
                },
              ),
              // Feedback
              FeedbackButton.listItem(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              // Log out
              ListTile(
                leading: Icon(Icons.update),
                title: Text("What's New?"),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => WhatsNew.dialog(),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log out'),
                onTap: () {
                  Navigator.pop(context);
                  auth.signOutFlow(auth.SignInMethod.Google);
                },
              ),
            ];

        return Drawer(
          child: ListView(
            children: items,
          ),
        );
      },
    );
  }

  void createNewCharacterScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<bool>(
        fullscreenDialog: true,
        builder: (context) => CharacterWizardView(),
      ),
    );
  }

  Widget title(String text, BuildContext context) {
    TextStyle titleStyle = getTitleStyle(context);
    Widget title = Padding(
      padding: EdgeInsets.all(16).copyWith(bottom: 0),
      child: Text(
        text.toUpperCase(),
        style: titleStyle,
      ),
    );
    return title;
  }

  TextStyle getTitleStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 12,
    );
  }

  List<Widget> characterList(
      Map<String, Character> characters, BuildContext context) {
    if (characters == null || characters.isEmpty) return [];
    return characters.values.map((character) {
      if (character?.displayName == null) return Container();
      return ListTile(
        leading: Icon(Icons.person),
        title: Text(character.displayName),
        selected: dwStore.state.characters.currentCharDocID == character.docID,
        onTap: () {
          dwStore.dispatch(
              CharacterActions.setCurrentChar(character.docID, character));
          Navigator.pop(context);
        },
      );
    }).toList();
  }
}
