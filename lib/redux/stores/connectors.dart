import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DWStoreConnector extends StatelessWidget {
  final Widget Function(BuildContext context, DWStore state) builder;
  final Widget loader;

  const DWStoreConnector({Key key, @required this.builder, this.loader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<DWStore>(
      store: dwStore,
      child: StoreConnector<DWStore, DWStore>(
          converter: (store) => store.state,
          builder: (context, state) {
            // if (state['loading'] == true) {
            //   return loader;
            // }

            return builder(context, state);
          }),
    );
  }
}
