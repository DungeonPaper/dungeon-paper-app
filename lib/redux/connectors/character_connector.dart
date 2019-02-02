import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores/character_store.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CharacterConnector extends StatelessWidget {
  final Widget Function(BuildContext context, DbCharacter character) builder;
  final Widget loader;

  const CharacterConnector({Key key, @required this.builder, this.loader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<CharacterStore>(
      store: characterStore,
      child: StoreConnector<CharacterStore, CharacterStore>(
          converter: (store) => store.state,
          builder: (context, state) {
            // if (state['loading'] == true) {
            //   return loader;
            // }

            return builder(context, state.character);
          }),
    );
  }
}
