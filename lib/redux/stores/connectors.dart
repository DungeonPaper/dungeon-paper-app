import 'package:dungeon_paper/redux/stores/loading_reducer.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DWStoreConnector extends StatelessWidget {
  final Widget Function(BuildContext context, DWStore state) builder;
  final Widget loader;
  final LoadingKeys loaderKey;

  const DWStoreConnector(
      {Key key,
      @required this.builder,
      this.loader,
      this.loaderKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<DWStore>(
      store: dwStore,
      child: StoreConnector<DWStore, DWStore>(
          converter: (store) => store.state,
          builder: (context, state) {
            if (loaderKey != null && state.loading.keys.contains(loaderKey) && state.loading[loaderKey]) {
              return loader;
            }
            return builder(context, state);
          }),
    );
  }
}
