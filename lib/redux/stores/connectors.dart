import 'package:dungeon_paper/redux/stores/loading_store.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class DWStoreConnector<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T state) builder;
  final Widget Function(BuildContext context) loader;
  final List<LoadingKeys> loaderKeys;
  final T Function(Store<DWStore> store) converter;

  const DWStoreConnector({
    Key key,
    @required this.builder,
    this.converter,
    this.loader,
    this.loaderKeys,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Function(Store<DWStore> store) _converter =
        converter != null ? converter : (store) => store.state;

    return StoreConnector<DWStore, T>(
        converter: _converter,
        builder: (context, state) {
          DWStore store = dwStore.state;

          if (loaderKeys != null &&
              loaderKeys.isNotEmpty &&
              loaderKeys.any((k) => store.loading[k])) {
            return loader(context);
          }

          return builder(context, state);
        });
  }
}
