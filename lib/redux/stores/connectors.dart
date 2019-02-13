import 'package:dungeon_paper/redux/stores/loading_reducer.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class DWStoreConnector extends StatelessWidget {
  final Widget Function(BuildContext context, DWStore state) builder;
  final Widget Function(BuildContext context) loader;
  final LoadingKeys loaderKey;
  final dynamic Function(Store<DWStore> store) converter;

  const DWStoreConnector({
    Key key,
    @required this.builder,
    this.converter,
    this.loader,
    this.loaderKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Function(Store<DWStore> store) _converter =
        converter != null ? converter : (store) => store.state;

    return StoreProvider<DWStore>(
      store: dwStore,
      child: StoreConnector<DWStore, DWStore>(
          converter: _converter,
          builder: (context, state) {
            if (loaderKey != null &&
                state.loading.keys.contains(loaderKey) &&
                state.loading[loaderKey]) {
              return loader(context);
            }
            return builder(context, state);
          }),
    );
  }
}
