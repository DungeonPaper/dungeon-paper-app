import 'package:dungeon_paper/db/auth.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions/character_actions.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  @override
  SidebarState createState() {
    return new SidebarState();
  }
}

class SidebarState extends State<Sidebar> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector<DWStore>(
      builder: (context, state) {
        List<Widget> characterItems = [];
        DbUser user = state.user.current;

        Widget title = UserAccountsDrawerHeader(
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
          onDetailsPressed: () {
            setState(() {
              expanded = !expanded;
            });
          },
        );
        Widget addNew = ListTile(
          title: Text('+ Create Empty Character'),
          onTap: () {
            createNewCharacter();
          },
        );
        Widget logOut = ListTile(
          title: Text('Log out'),
          onTap: () {
            requestSignOut();
          },
        );
        characterItems.add(title);
        state.characters.characters.forEach((id, character) {
          Widget charLine = ListTile(
            title: Text(character.displayName),
            onTap: () {
              dwStore.dispatch(CharacterActions.setCurrentChar(id, character));
              Navigator.pop(context);
            },
          );
          characterItems.add(charLine);
        });
        characterItems.add(addNew);
        characterItems.add(logOut);

        return Drawer(
          child: ListView(
            children: characterItems,
          ),
        );
      },
    );
  }
}
