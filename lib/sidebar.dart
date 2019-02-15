import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/actions/character_actions.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DWStoreConnector<DWStore>(
      builder: (context, state) {
        DbUser user = state.user.current;
        Widget title = UserAccountsDrawerHeader(
          accountEmail: Text(user.email),
          accountName: Text(user.displayName),
        );
        Widget addNew = ListTile(
            title: Text('+ Create Empty Character'),
            onTap: () {
              createCharacter();
            },
          );
        List<Widget> characterItems = [title];
        state.characters.characters.forEach((id, character) {
          Widget charLine = ListTile(
            title: Text(character.displayName),
            onTap: () {
              dwStore.dispatch(CharacterActions.setCurrentChar(id, character));
            },
          );
          characterItems.add(charLine);
        });

        return Drawer(
          child: ListView(
            children: characterItems,
          ),
        );
      },
    );
  }
}
