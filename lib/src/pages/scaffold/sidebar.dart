import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:dungeon_paper/src/pages/about_view/about_view.dart';
import 'package:dungeon_paper/src/pages/character_wizard/character_wizard_view.dart';
import 'package:dungeon_paper/src/pages/compendium/compendium_view.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/connectors.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
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
        var user = state.user.current;

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
                leading: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('+ Create New'.toUpperCase()),
                        ),
                        onTap: () => createNewCharacterScreen(context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('Manage'.toUpperCase()),
                        ),
                        onTap: () => manageCharactersScreen(context),
                      ),
                    ),
                  ],
                ),
              ),
              ...characterList(state.characters.characters, context),
              Divider(),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4),
                  child: PlatformSvg.asset(
                    'book-stack.svg',
                    width: 16,
                    height: 16,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black45
                        : Theme.of(context).accentColor,
                  ),
                ),
                title: Text('Compendium'),
                onTap: () => compendiumScreen(context),
              ),
              Divider(),
              title('Application', context),
              // About
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () => aboutScreen(context),
              ),
              // Log out
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
    Navigator.pop(context);
    openPage(context,
        builder: (context) => CharacterWizardView(
              character: null,
              mode: DialogMode.Create,
              onSave: (char) => dwStore.dispatch(SetCurrentChar(char)),
            ));
  }

  void manageCharactersScreen(BuildContext context) {
    Navigator.pop(context);
    openPage(context, builder: (context) => ManageCharactersView());
  }

  void compendiumScreen(BuildContext context) {
    Navigator.pop(context);
    openPage(
      context,
      builder: (context) => Compendium(),
    );
  }

  void aboutScreen(BuildContext context) {
    Navigator.pop(context);
    openPage(context, builder: (context) => AboutView());
  }

  Widget title(String text, BuildContext context, {Widget leading}) {
    var titleStyle = getTitleStyle(context);
    Widget title = Padding(
      padding: EdgeInsets.all(8),
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
        DefaultTextStyle(
          child: leading,
          style: titleStyle.copyWith(
              color: Theme.of(context).textTheme.headline3.color),
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
      selectedId: dwStore.state.characters.current.documentID,
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
                key: Key(character.documentID),
                character: character,
                selected:
                    selectedId != null && selectedId == character.documentID,
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
