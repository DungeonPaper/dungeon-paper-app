import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final bool loading;
  final Widget Function() builder;
  final Widget child;
  final Widget loader;

  const LoadingContainer({
    Key key,
    @required this.loading,
    this.builder,
    this.child,
    this.loader,
  })  : assert(builder != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return loader ?? Center(child: Loader());
    }
    return child ?? builder?.call();
  }
}
