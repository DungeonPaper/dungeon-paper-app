import 'package:dungeon_paper/db/auth.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions/character_actions.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DWStoreConnector<DWStore>(
      builder: (context, state) {
        DbUser user = state.user.current;
        List<Widget> items = [
              header(user),
              title('Characters', context),
            ] +
            characterList(state.characters.characters, context) +
            [
              Divider(),
              title('Application', context),
              addNew(),
              logOut(context),
            ];

        return Drawer(
          child: ListView(
            children: items,
          ),
        );
      },
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

  Widget logOut(BuildContext context) {
    Widget logOut = ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Log out'),
      onTap: doLogOut(context),
    );
    return logOut;
  }

  Widget addNew() {
    Widget addNew = ListTile(
      leading: Icon(Icons.add),
      title: Text('Create Empty Character'),
      onTap: addNewCharacter,
    );
    return addNew;
  }

  Widget header(DbUser user) {
    Widget header = UserAccountsDrawerHeader(
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
    );
    return header;
  }

  TextStyle getTitleStyle(BuildContext context) => TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 12,
      );

  List<ListTile> characterList(
      Map<String, DbCharacter> characters, BuildContext context) {
    return characters.keys.map((id) {
      DbCharacter character = characters[id];
      return ListTile(
        leading: Icon(Icons.person),
        title: Text(character.displayName),
        onTap: () {
          dwStore.dispatch(CharacterActions.setCurrentChar(id, character));
          Navigator.pop(context);
        },
      );
    }).toList();
  }

  void Function() doLogOut(BuildContext context) {
    return () {
      Navigator.pop(context);
      requestSignOut();
    };
  }

  void addNewCharacter() {
    createNewCharacter();
  }
}
