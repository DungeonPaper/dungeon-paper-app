import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/redux/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserConnector extends StatelessWidget {
  final Widget Function(BuildContext context, DbUser user) builder;
  final Widget loader;

  UserConnector({Key key, @required this.builder, this.loader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<UserStore>(
      store: userStore,
      child: StoreConnector<UserStore, UserStore>(
        converter: (characterStore) => characterStore.state,
        builder: (context, state) {
          // if (state['loading'] == true) {
          //   return loader;
          // }

          if (state.user == null) {
            _getDetailsFromPrefs(context);
          }

          return builder(context, state.user);
        },
      ),
    );
  }

  _getDetailsFromPrefs(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('userEmail');
    String characterId = prefs.getString('characterId');

    if (userEmail == null || characterId == null) {
      return;
    }

    await setCurrentUserByEmail(userEmail);
    await setCurrentCharacterById(characterId);
  }
}
