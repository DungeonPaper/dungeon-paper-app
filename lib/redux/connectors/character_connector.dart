
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CharacterConnector extends StatelessWidget {
  final Widget Function(BuildContext context, DbCharacter character) builder;
  final Widget loader;
  const CharacterConnector({Key key, this.builder, this.loader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: characterStore,
      child: StoreConnector<Map, Map>(
          converter: (store) => store.state,
          builder: (context, state) {
            if (state['loading'] == true) {
              return loader;
            }

            return builder(context, state['data']);
          }),
    );
  }
}
