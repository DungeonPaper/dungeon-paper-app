import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/redux/stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserConnector extends StatelessWidget {
  final Widget loader;
  final Widget Function(BuildContext context, DbUser user) builder;
  UserConnector({Key key, this.loader, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<Map>(
      store: userStore,
      child: StoreConnector<Map, Map>(
        converter: (characterStore) => characterStore.state,
        builder: (context, state) {
          if (state['loading'] == true) {
            return loader;
          }

          if (state['data'] == null) {
            _getDetailsFromPrefs(context);
          }

          return builder(context, state['data']);
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

    await setCurrentUserByField('email', userEmail);
    await setCurrentCharacterById(characterId);
  }
}
