import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/atoms/feedback_button.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/pages/about_view/about_view.dart';
import 'package:dungeon_paper/src/pages/character_wizard/character_wizard_view.dart';
import 'package:dungeon_paper/src/pages/whats_new_view/whats_new_view.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/connectors.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/scaffolds/custom_class_wizard/custom_class_wizard.dart';
import 'package:dungeon_paper/src/scaffolds/manage_characters_view/manage_characters_view.dart';
import 'package:dungeon_paper/src/utils/auth.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  // bool _userMenuExpanded = false;

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector<DWStore>(
      builder: (context, state) {
        User user = state.user.current;

        return Drawer(
          child: ListView(
            children: [
              UserDrawerHeader(
                user: user,
                onToggleUserMenu: null,
                // onToggleUserMenu: () {
                //   setState(() {
                //     _userMenuExpanded = !_userMenuExpanded;
                //   });
                // },
              ),
              // if (!_userMenuExpanded) ...[
              title(
                'Characters',
                context,
                leading: InkWell(
                  child: Text('Edit'.toUpperCase()),
                  onTap: () => manageCharactersScreen(context),
                ),
              ),
              ...characterList(state.characters.characters, context),
              Divider(),
              // Create Empty Character
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Create New Character'),
                onTap: () {
                  Navigator.pop(context);
                  createNewCharacterScreen(context);
                },
              ),
              if (user.hasFeature('create_custom_class'))
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Create New Class'),
                  onTap: () {
                    Navigator.pop(context);
                    createNewClassScreen(context);
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
                  aboutScreen(context);
                },
              ),
              // Feedback
              FeedbackButton.listItem(onPressed: () => Navigator.pop(context)),
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
              // ],
              // if (_userMenuExpanded)
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log out'),
                onTap: () {
                  Navigator.pop(context);
                  signOutFlow();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void openPage(BuildContext context,
      {Widget Function(BuildContext) builder, bool fullScreenDialog = true}) {
    Navigator.push(
      context,
      MaterialPageRoute<bool>(
        fullscreenDialog: fullScreenDialog,
        builder: builder,
      ),
    );
  }

  void createNewCharacterScreen(BuildContext context) {
    openPage(context, builder: (context) => CharacterWizardView());
  }

  void manageCharactersScreen(BuildContext context) {
    openPage(context, builder: (context) => ManageCharactersView());
  }

  void createNewClassScreen(BuildContext context) {
    openPage(
      context,
      builder: (context) => CustomClassWizard(mode: DialogMode.Create),
    );
  }

  void aboutScreen(BuildContext context) {
    openPage(context, builder: (context) => AboutView());
  }

  Widget title(String text, BuildContext context, {Widget leading}) {
    TextStyle titleStyle = getTitleStyle(context);
    Widget title = Padding(
      padding: EdgeInsets.all(16).copyWith(bottom: 0),
      child: Text(
        text.toUpperCase(),
        style: titleStyle,
      ),
    );
    if (leading == null) {
      return title;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title,
        Padding(
          padding: EdgeInsets.all(16).copyWith(bottom: 0),
          child: DefaultTextStyle(
            child: leading,
            style: titleStyle.copyWith(
                color: Theme.of(context).textTheme.headline3.color),
          ),
        ),
      ],
    );
  }

  TextStyle getTitleStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 12,
    );
  }

  List<Widget> characterList(
      Map<String, Character> characters, BuildContext context) {
    if (characters == null || characters.isEmpty) {
      return [];
    }
    return CharacterListTile.list(
      characters.values.toList()..sort((ch1, ch2) => ch1.order - ch2.order),
      selectedId: dwStore.state.characters.current.docID,
    );
  }
}

class CharacterListTile extends StatelessWidget {
  final Character character;
  final bool selected;
  const CharacterListTile({
    Key key,
    @required this.character,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (character?.displayName == null) {
      return Container(height: 0);
    }
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(character.displayName),
      selected: selected,
      onTap: () {
        dwStore.dispatch(SetCurrentChar(character));
        Navigator.pop(context);
      },
    );
  }

  static List<Widget> list(Iterable<Character> characters,
          {String selectedId}) =>
      characters
          .map((character) => CharacterListTile(
                key: Key(character.docID),
                character: character,
                selected: selectedId != null && selectedId == character.docID,
              ))
          .toList();
}

class UserDrawerHeader extends StatelessWidget {
  const UserDrawerHeader({
    Key key,
    @required this.user,
    @required this.onToggleUserMenu,
  }) : super(key: key);

  final User user;
  final void Function() onToggleUserMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
          onDetailsPressed: onToggleUserMenu,
        ),
      ],
    );
  }
}