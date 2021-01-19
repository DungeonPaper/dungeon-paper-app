import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'loading/loading_controller.dart';
import 'stores.dart';

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

  T Function(Store<DWStore> store) get _converter =>
      converter ?? (store) => store.state as T;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<DWStore, T>(
        converter: _converter,
        builder: (context, state) {
          var keys = dwStore.state.loading;

          if (loaderKeys != null &&
              loaderKeys.isNotEmpty &&
              loaderKeys.any((k) => keys[k] == true)) {
            return loader(context);
          }

          return builder(context, state);
        });
  }
}
