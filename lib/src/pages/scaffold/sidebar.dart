import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/atoms/user_avatar.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:dungeon_paper/src/pages/about_view/about_view.dart';
import 'package:dungeon_paper/src/pages/account_view/account_view.dart';
import 'package:dungeon_paper/src/pages/edit_character/edit_character_view.dart';
import 'package:dungeon_paper/src/pages/compendium/compendium_view.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/connectors.dart';
import 'package:dungeon_paper/src/redux/shared_preferences/prefs_settings.dart';
import 'package:dungeon_paper/src/redux/shared_preferences/prefs_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/scaffolds/manage_characters_view/manage_characters_view.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/auth/auth.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool _userMenuExpanded;

  @override
  void initState() {
    super.initState();
    logger.d('Open Sidebar');
    _userMenuExpanded = false;
    analytics.logEvent(name: Events.OpenSidebar);
  }

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector<DWStore>(
      builder: (context, state) {
        var user = state.user.current;
        var settings = state.prefs.settings;
        // ignore: unused_local_variable
        var buttonStyle = getTitleStyle(context).copyWith(
          color: Theme.of(context).textTheme.headline3.color,
        );

        return Drawer(
          child: ListView(
            children: [
              UserDrawerHeader(
                user: user,
                onToggleUserMenu: () {
                  setState(() {
                    _userMenuExpanded = !_userMenuExpanded;
                  });
                },
              ),
              if (_userMenuExpanded) ...[
                // ListTile(
                //   title: Text('Link with Email'),
                //   onTap: () => showDialog(
                //     context: context,
                //     builder: (context) => EmailAuthView(
                //       signUpMode: true,
                //       linkMode: true,
                //       onLoggedIn: (_) => Navigator.pop(context),
                //     ),
                //   ),
                // ),
                // Log out
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Account'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => AccountView(),
                    ),
                  ),
                ),
                // Log out
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Log out'),
                  onTap: () {
                    Navigator.pop(context);
                    signOutAll();
                  },
                ),
              ],
              title(
                'Characters',
                context,
                leading: Row(
                  children: [
                    IconButton(
                      color: Theme.of(context).accentColor,
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.add),
                      tooltip: 'Create new character',
                      onPressed: () => createNewCharacterScreen(context),
                    ),
                    IconButton(
                      color: Theme.of(context).accentColor,
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.settings),
                      tooltip: 'Manage characters',
                      onPressed: () => manageCharactersScreen(context),
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
              title('Settings', context),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Keep screen on'),
                trailing: Switch.adaptive(
                  value: settings.keepScreenOn,
                  onChanged: (value) {
                    dwStore.dispatch(
                      ChangeSetting<bool>(
                        name: SettingName.keepScreenOn,
                        value: value,
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              title('Application', context),
              // About
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () => aboutScreen(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void openPage(
    String pageName,
    BuildContext context, {
    Widget Function(BuildContext) builder,
    bool fullScreenDialog = true,
  }) {
    logger.d('Page View: $pageName');
    analytics.setCurrentScreen(screenName: pageName);
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
    openPage(
      ScreenNames.CharacterScreen,
      context,
      builder: (context) => EditCharacterView(
        character: null,
        mode: DialogMode.Create,
        onSave: (char) => dwStore.dispatch(SetCurrentChar(char)),
      ),
    );
  }

  void manageCharactersScreen(BuildContext context) {
    Navigator.pop(context);
    openPage(
      ScreenNames.ManageCharacters,
      context,
      builder: (context) => ManageCharactersView(),
    );
  }

  void compendiumScreen(BuildContext context) {
    Navigator.pop(context);
    openPage(
      ScreenNames.Compendium,
      context,
      builder: (context) => Compendium(),
    );
  }

  void aboutScreen(BuildContext context) {
    Navigator.pop(context);
    openPage(
      ScreenNames.About,
      context,
      builder: (context) => AboutView(),
    );
  }

  Widget title(String text, BuildContext context, {Widget leading}) {
    var titleStyle = getTitleStyle(context);
    Widget title = Padding(
      padding: EdgeInsets.all(8).copyWith(left: 18),
      child: Text(
        text.toUpperCase(),
        style: titleStyle,
      ),
    );
    if (leading == null) {
      return title;
    }
    var leadingStyle = titleStyle.copyWith(
      color: Theme.of(context).textTheme.headline3.color,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title,
        DefaultTextStyle(
          child: leading,
          style: leadingStyle,
        ),
      ],
    );
  }

  TextStyle getTitleStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).accentColor,
      fontWeight: FontWeight.w700,
      fontSize: 14,
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
    return ListTileTheme.merge(
      selectedColor: Theme.of(context).colorScheme.secondaryVariant,
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(character.displayName),
        selected: selected,
        onTap: () {
          logger.d('Set Current Char: $character');
          analytics.logEvent(name: Events.ChangeCharacter, parameters: {
            'documentID': character.documentID,
            'order': character.order,
          });
          dwStore.dispatch(SetCurrentChar(character));
          Navigator.pop(context);
        },
      ),
    );
  }

  static List<Widget> list(
    Iterable<Character> characters, {
    String selectedId,
  }) =>
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
          decoration: BoxDecoration(color: Theme.of(context).accentColor),
          accountEmail: Text(
            user.email,
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
          accountName: Text(
            user.displayName,
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
          currentAccountPicture: UserAvatar(user: user),
          onDetailsPressed: onToggleUserMenu,
        ),
      ],
    );
  }
}
